function get_id(clicked_id) {
  Shiny.setInputValue("records-current_id", clicked_id, {priority: "event"});
}
