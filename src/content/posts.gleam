import content.{type Page, type Post, List, Page, Section}
import gleam/list
import post
import standards

pub fn page(posts: List(Post)) -> Page {
  Page(
    title: "Links to posts",
    content: [Section([List(list.map(posts, post.link))])],
    footer: standards.footer(),
  )
}
