import content.{type Page, type Post, List, Page, Paragraph, Section, Text}
import gleam/list
import post

pub fn page(posts: List(Post)) -> Page {
  Page(
    title: "Links to posts",
    content: [Section([List(list.map(posts, post.link))])],
    footer: Paragraph([Text("footer")]),
  )
}
