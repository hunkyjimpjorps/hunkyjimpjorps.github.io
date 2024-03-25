import content.{type Post, Post}
import gleam/option.{Some}
import gleam/regex.{Match}
import gleam/string

fn to_month(month: String) {
  case month {
    "01" -> "January"
    "02" -> "February"
    "03" -> "March"
    "04" -> "April"
    "05" -> "May"
    "06" -> "June"
    "07" -> "July"
    "08" -> "August"
    "09" -> "September"
    "10" -> "October"
    "11" -> "November"
    "12" -> "December"
    _ -> panic
  }
}

pub fn match_to_date(match) {
  case match {
    [Match(_, [Some(year), Some(month), Some(day)])] ->
      day <> " " <> to_month(month) <> " " <> year
    _ -> ""
  }
}

pub fn compare(post1: Post, post2: Post) {
  string.compare(post2.date, post1.date)
}
