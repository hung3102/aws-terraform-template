// create cloudfront function to rewrite /jobs to /jobs.html
resource "aws_cloudfront_function" "append_html_suffix" {
  name    = "suffix-html"
  runtime = "cloudfront-js-1.0"
  comment = "Rewrite append .html to url path"
  code    = <<EOT
function handler(event) {
    var request = event.request;
    var uri = request.uri;

    // If the request has no file extension (e.g., "/jobs"), rewrite to "/jobs.html"
    if (!uri.includes('.') && !uri.endsWith('/')) {
        request.uri += ".html";
    }

    return request;
}
EOT
}

// create function route dynamic path from /jobs/[id]/ to jobs/jobDynamicId/
resource "aws_cloudfront_function" "route_dynamic_job_id" {
  name    = "route-dynamic-path"
  runtime = "cloudfront-js-1.0"
  comment = "Rewrite /jobs/[id]/ to /jobs/jobDynamicId/"
  code    = <<EOT
function handler(event) {
    var request = event.request;
    var uri = request.uri;

    // Match the pattern /jobs/{id}/
    var match = uri.match(/^\/jobs\/([^\/]+)\/$/);
    
    if (match) {
        // Rewrite to /jobs/jobDynamicId/
        request.uri = "/jobs/jobDynamicId/";
    }

    return request;
}
EOT
}
