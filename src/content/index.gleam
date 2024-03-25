import content.{
  type Page, type Post, List, Page, Paragraph, Section, Text, Title,
}
import gleam/list
import post
import date
import standards

pub fn page(posts: List(Post)) -> Page {
  Page(
    title: "Home",
    content: [
      Title("jimpjorps writes stuff"),
      Section([
        Paragraph([Text("All published posts")]),
        List(
          posts
          |> list.sort(by: date.compare)
          |> list.map(post.link_and_above),
        ),
      ]),
    ],
    footer: standards.footer(),
  )
}
