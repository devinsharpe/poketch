import app/router
import app/web
import dotenv_gleam
import envoy
import gleam/erlang/process
import mist
import wisp
import wisp/wisp_mist

pub fn main() -> Nil {
  let assert Ok(Nil) = dotenv_gleam.config_with("./.env")
  let assert Ok(secret_key) = envoy.get("SECRET_KEY")

  wisp.configure_logger()

  let context = web.Context(name: "Jonathan")
  let handler = router.handle_request(_, context)

  let assert Ok(_) =
    handler
    |> wisp_mist.handler(secret_key)
    |> mist.new
    |> mist.port(8000)
    |> mist.start_http

  process.sleep_forever()
}
