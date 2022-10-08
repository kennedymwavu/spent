function get_id(clicked_id) {
  Shiny.setInputValue("get-current_id", clicked_id, {priority: "event"});
}
