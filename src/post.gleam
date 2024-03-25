import content.{
  type Content, type Err, type Page, type Post, Grid, Link, Page, Paragraph,
  Post, Section, StaticMarkdown, StringError, Text,
}
import gleam/result
import gleam/string
import simplifile
import gleam/io

const post_path = "/posts/"

const posts_dir = "./static/posts/"

pub fn post(filename: String) -> Result(Post, Err) {
  use #(title, _) <- result.map(
    filename
    |> string.split_once(".md")
    |> result.replace_error(StringError(
      "failed to remove .md suffix from '" <> filename <> "'",
    )),
  )
  Post(
    path: title,
    title: title
      |> string.replace("_", " ")
      |> string.replace("-", " ")
      |> string.capitalise,
    src: post_path <> filename,
    static: posts_dir <> filename,
  )
}

pub fn link(post: Post) -> Content {
  Link(href: post_path <> post.path, text: post.title)
}

pub fn dynamic_route(post: Post) -> #(String, Page) {
  #(post.path, Page(title: post.title, content: [StaticMarkdown(post.src)]))
}

pub fn above_the_fold(post: Post) -> Result(Content, Nil) {
  io.debug(post.static)
  let assert Ok(all_content) = simplifile.read(post.static)

  let above = case string.split_once(all_content, "<!--more-->") {
    Ok(#(top, _)) -> Ok(Paragraph([Text(top)]))
    Error(_) -> Error(Nil)
  }
}

pub fn link_and_above(post: Post) -> Content {
  case above_the_fold(post) {
    Ok(text) -> Section([link(post), text])
    Error(_) -> link(post)
  }
}
