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

		if (!Uri.TryCreate(_opt.WebhookUrl, UriKind.Absolute, out var uri))
			throw new InvalidOperationException("Teams webhook URL is invalid.");

		var endpointType = ResolveEndpointType(uri, _opt.EndpointType);
		var payload = endpointType == TeamsEndpointType.Workflow
			? BuildWorkflowPayload(msg)
			: BuildLegacyMessageCardPayload(msg);

		var http = _httpFactory.CreateClient();

		try
		{
			using var resp = await http.PostAsJsonAsync(uri, payload, ct);
			if (!resp.IsSuccessStatusCode)
			{
				var body = await resp.Content.ReadAsStringAsync(ct);
				throw new HttpRequestException(
					$"Teams webhook call failed. Status={(int)resp.StatusCode} {resp.ReasonPhrase}. Response={body}");
			}

			_logger.LogInformation("Teams {EndpointType} message sent.", endpointType);
		}
		catch (Exception ex)
		{
			_logger.LogError(ex, "Failed to send Teams {EndpointType} message.", endpointType);
			throw;
		}
	}

	private static TeamsEndpointType ResolveEndpointType(Uri uri, string? configuredValue)
	{
		if (!string.IsNullOrWhiteSpace(configuredValue))
		{
			if (configuredValue.Equals("Workflow", StringComparison.OrdinalIgnoreCase))
				return TeamsEndpointType.Workflow;
			if (configuredValue.Equals("LegacyWebhook", StringComparison.OrdinalIgnoreCase))
				return TeamsEndpointType.LegacyWebhook;
		}

		var host = uri.Host ?? string.Empty;
		var pathAndQuery = (uri.AbsolutePath + uri.Query).ToLowerInvariant();

		if (host.Contains("logic.azure.com", StringComparison.OrdinalIgnoreCase) ||
			host.Contains("logic-apis", StringComparison.OrdinalIgnoreCase) ||
			pathAndQuery.Contains("/triggers/manual/") ||
			pathAndQuery.Contains("/paths/invoke") ||
			pathAndQuery.Contains("sig="))
		{
			return TeamsEndpointType.Workflow;
		}

		return TeamsEndpointType.LegacyWebhook;
	}

	private static object BuildLegacyMessageCardPayload(TeamsNotification msg)
	{
		return new
		{
			@type = "MessageCard",
			@context = "http://schema.org/extensions",
			summary = msg.Title,
			title = msg.Title,
			text = (msg.Message ?? string.Empty).Replace("\n", "<br/>")
		};
	}

	private static object BuildWorkflowPayload(TeamsNotification msg)
	{
		return new
		{
			type = "message",
			attachments = new object[]
			{
			new
			{
				contentType = "application/vnd.microsoft.card.adaptive",
				contentUrl = (string?)null,
				content = new Dictionary<string, object?>
				{
					["$schema"] = "http://adaptivecards.io/schemas/adaptive-card.json",
					["type"] = "AdaptiveCard",
					["version"] = "1.4",
					["body"] = new object[]
					{
						new Dictionary<string, object?>
						{
							["type"] = "TextBlock",
							["text"] = msg.Title,
							["weight"] = "Bolder",
							["size"] = "Medium",
							["wrap"] = true
						},
						new Dictionary<string, object?>
						{
							["type"] = "TextBlock",
							["text"] = msg.Message,
							["wrap"] = true
						}
					}
				}
			}
			}
		};
	}

	private enum TeamsEndpointType
	{
		Workflow,
		LegacyWebhook
	}
}
