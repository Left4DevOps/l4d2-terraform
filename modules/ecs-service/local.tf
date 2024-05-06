locals {
  name           = "${local.long_game_name}-${var.port}"
  long_game_name = var.game == "l4d" ? "left4dead" : "left4dead2"
  net_con_port   = var.net_con_diff > 0 ? var.port - var.net_con_diff : var.net_con_port
  public_cidr    = "0.0.0.0/0"
}