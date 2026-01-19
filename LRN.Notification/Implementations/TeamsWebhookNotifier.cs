using LRN.Notifications.Abstractions;
using LRN.Notifications.Models;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using System.Net.Http;
using System.Net.Http.Json;

namespace LRN.Notifications.Implementations;

public sealed class TeamsWebhookNotifier : ITeamsNotifier
{
	private readonly TeamsWebhookOptions _opt;
	private readonly IHttpClientFactory _httpFactory;
	private readonly ILogger<TeamsWebhookNotifier> _logger;

	public TeamsWebhookNotifier(
		IOptions<TeamsWebhookOptions> opt,
		IHttpClientFactory httpFactory,
		ILogger<TeamsWebhookNotifier> logger)
	{
		_opt = opt.Value;
		_httpFactory = httpFactory;
		_logger = logger;
	}

	public async Task SendAsync(TeamsNotification msg, CancellationToken ct = default)
	{
		if (!_opt.Enabled) return;

		if (string.IsNullOrWhiteSpace(_opt.WebhookUrl))
			throw new InvalidOperationException("Teams webhook URL is not configured.");

		if (string.IsNullOrWhiteSpace(msg.Message))
			throw new ArgumentException("TeamsNotification.Message is required.");

		// MessageCard payload (works well for webhooks)
		var payload = new
		{
			@type = "MessageCard",
			@context = "http://schema.org/extensions",
			summary = msg.Title,
			title = msg.Title,
			text = (msg.Message ?? "").Replace("\n", "<br/>")
		};

		var http = _httpFactory.CreateClient();

		try
		{
			using var resp = await http.PostAsJsonAsync(_opt.WebhookUrl, payload, ct);
			resp.EnsureSuccessStatusCode();

			_logger.LogInformation("Teams webhook message sent.");
		}
		catch (Exception ex)
		{
			_logger.LogError(ex, "Failed to send Teams webhook message.");
			throw;
		}
	}
}
