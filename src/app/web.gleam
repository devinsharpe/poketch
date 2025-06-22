import wisp

pub type Context {
  Context(name: String)
}

pub fn middleware(
  req: wisp.Request,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  // Allow browsers to simulate other HTTP methods via a `_method` query param
  let req = wisp.method_override(req)
  // Log information about the request and response.
  use <- wisp.log_request(req)
  // Return a default 500 response if the request handler crashes.
  use <- wisp.rescue_crashes
  // Rewrite HEAD requests to GET requests and return an empty body.
  use req <- wisp.handle_head(req)
  // Handle the request!
  handle_request(req)
}
