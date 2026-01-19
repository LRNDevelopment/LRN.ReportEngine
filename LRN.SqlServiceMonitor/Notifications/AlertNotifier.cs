using LRN.Notifications.Abstractions;
using LRN.Notifications.Models;
using LRN.SqlServiceMonitor;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace LRN.SqlServiceMonitor.Notifications;

public interface IAlertNotifier
{
    Task NotifyAsync(string title, string message, CancellationToken ct);
}

public sealed class AlertNotifier : IAlertNotifier
{
    private readonly IEmailNotifier _email;
    private readonly ITeamsNotifier _teams;
    private readonly AlertOptions _opt;
    private readonly ILogger<AlertNotifier> _logger;

    public AlertNotifier(
        IEmailNotifier email,
        ITeamsNotifier teams,
        IOptions<AlertOptions> opt,
        ILogger<AlertNotifier> logger)
    {
        _email = email;
        _teams = teams;
        _opt = opt.Value;
        _logger = logger;
    }

    public async Task NotifyAsync(string title, string message, CancellationToken ct)
    {
        if (!_opt.Enabled) return;

        // Send email (if From + To configured)
        if (!string.IsNullOrWhiteSpace(_opt.EmailFrom) && _opt.EmailTo.Count > 0)
        {
            var subject = $"{_opt.EmailSubjectPrefix} {title}".Trim();

            var email = new EmailNotification
            {
                From = _opt.EmailFrom,
                To = _opt.EmailTo,
                Cc = _opt.EmailCc,
                Bcc = _opt.EmailBcc,
                Subject = subject,
                Content = message,
                IsHtml = false
            };

            try
            {
                await _email.SendAsync(email, ct);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Email notification failed.");
            }
        }
        else
        {
            _logger.LogWarning("Email notification skipped (EmailFrom/EmailTo not configured).");
        }

        // Send Teams (webhook to channel)
        try
        {
            var teamsMsg = new TeamsNotification
            {
                Title = $"{_opt.TeamsTitlePrefix} {title}".Trim(),
                Message = message
            };

            await _teams.SendAsync(teamsMsg, ct);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Teams notification failed.");
        }
    }
}
