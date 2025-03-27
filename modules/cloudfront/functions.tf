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
