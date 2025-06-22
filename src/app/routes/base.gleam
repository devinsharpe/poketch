import app/web
import gleam/http.{Get}
import gleam/string_tree
import wisp.{type Request, type Response}

pub fn hello(req: Request, ctx: web.Context) -> Response {
  case req.method {
    Get -> {
      let body = string_tree.from_string("<h1>Hello, " <> ctx.name <> "</h1>")
      wisp.html_response(body, 200)
    }
    _ -> wisp.method_not_allowed([Get])
  }
}
