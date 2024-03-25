import content.{
  type Page, type Post, Bold, Code, Heading, List, Page, Paragraph, Section,
  Snippet, Subheading, Text, Title,
}
import gleam/list
import post
import date

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
    footer: Paragraph([Text("footer")]),
  )
}
