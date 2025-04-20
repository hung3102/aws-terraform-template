resource "aws_cloudfront_function" "employer_viewer_request_function" {
  name    = "employer-viewer-request-rewriter"
  runtime = "cloudfront-js-1.0"
  comment = "Employer view-requestt function"
  code    = <<EOT
function handler(event) {
    var request = event.request;
    var uri = request.uri;

    // Match patterns like /jobs/{id}/, /jobs/{id}/applications, or /jobs/{id}/edit
    var match = uri.match(/^\/jobs\/([^\/]+)(\/applications|\/edit)?\/?$/);

    if (match) {
        var newUri = "/jobs/[id]";

        // Append /applications or /edit if present
        if (match[2]) {
            newUri += match[2];
        }

        request.uri = newUri;
        console.log("Rewritten URI:", request.uri);
    }

    // If the request has no file extension (e.g., "/jobs"), rewrite to "/jobs.html"
    if (!uri.includes('.') && !uri.endsWith('/')) {
        request.uri += ".html";
    }

    return request;
}
EOT
}

resource "aws_cloudfront_function" "user_viewer_request_function" {
  name    = "user-viewer-request-rewriter"
  runtime = "cloudfront-js-1.0"
  comment = "User view-request function"
  code    = <<EOT
function handler(event) {
    var request = event.request;
    var uri = request.uri;

    // Match patterns like:
    // /career-insights/{id}/
    // /companies/{id}/
    // /jobs/{id}/
    // /jobs/{id}/apply
    var match = uri.match(/^\/(career-insights|companies|jobs)\/([^\/]+)(\/apply)?\/?$/);

    if (match) {
        var section = match[1]; // career-insights, companies, or jobs
        var id = match[2]; // the dynamic ID
        var suffix = match[3] || ''; // /apply or nothing

        // Rewrite to format like /career-insights/[id], /companies/[id], /jobs/[id], /jobs/[id]/apply
        request.uri = "/" + section + "/[id]" + suffix;
        console.log("Rewritten URI:", request.uri);
    }

    // If the request has no file extension and doesn’t end with a slash, rewrite to .html
    if (!request.uri.includes('.') && !request.uri.endsWith('/')) {
        request.uri += ".html";
    }

    return request;
}

EOT
}
