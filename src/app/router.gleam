import app/web

import app/routes/base
import wisp.{type Request, type Response}

/// The HTTP request handler- your application!
pub fn handle_request(req: Request, ctx: web.Context) -> Response {
  use req <- web.middleware(req)
  case wisp.path_segments(req) {
    [] -> base.hello(req, ctx)
    _ -> wisp.not_found()
  }
}
