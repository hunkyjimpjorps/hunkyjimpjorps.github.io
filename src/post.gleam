import date
import content.{
  type Content, type Err, type InlineContent, type Page, type Post, InlineLink,
  Link, Page, Paragraph, Post, StaticMarkdown, StringError, Text,
}
import gleam/result
import gleam/string
import simplifile
import gleam/regex

const post_path = "/posts/"

const post_source_path = "./static/posts/"

pub fn post(filename: String) -> Result(Post, Err) {
  let assert Ok(re) = regex.from_string("-([0-9]{4})([0-9]{2})([0-9]{2}).md")
  let date =
    regex.scan(with: re, content: filename)
    |> date.match_to_date

  use #(title, _) <- result.map(
    filename
    |> string.split_once(".md")
    |> result.replace_error(StringError(
      "failed to remove .md suffix from '" <> filename <> "'",
    )),
  )
  let assert Ok(all_content) = simplifile.read(post_source_path <> filename)
  let subtitle = case string.split_once(all_content, "<!--more-->") {
    Ok(#(top, _)) -> Ok(Text(top))
    Error(_) -> Error(Nil)
  }
  Post(
    path: title,
    title: title
      |> string.replace("_", " ")
      |> string.replace("-", " ")
      |> string.capitalise,
    subtitle: subtitle,
    date: date,
    src: post_path <> filename,
  )
}

pub fn link(post: Post) -> Content {
  Link(href: post_path <> post.path, text: post.title)
}

pub fn inline_link(post: Post) -> InlineContent {
  InlineLink(href: post_path <> post.path, text: post.title)
}

pub fn dynamic_route(post: Post) -> #(String, Page) {
  #(post.path, Page(title: post.title, content: [StaticMarkdown(post.src)]))
}

pub fn link_and_above(post: Post) -> Content {
  case post.subtitle {
    Ok(text) -> Paragraph([inline_link(post), Text(post.date), text])
    Error(_) -> Paragraph([inline_link(post), Text(post.date)])
  }
}
