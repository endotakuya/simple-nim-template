import asyncdispatch, htmlgen, jester
import httpcore
import nre
import macros
# import strformat
# import typeinfo, typetraits

proc generateHTMLPage(title, currentTab, content: string, tabs: openArray[string]): string =
  result = ""
  result.add("<head><title>" & $(title) & "</title></head>\n" &
    "<body>\n" &
    "  <div id=\"menu\">\n" &
    "    <ul>\n")
  for tab in items(tabs):
    if currentTab == tab:
      result.add("    <li><a id=\"selected\" \n")
    else:
      result.add("    <li><a\n")
    #end
    result.add("    href=\"" & $(tab) & ".html\">" & $(tab) & "</a></li>\n")
  #end
  result.add("    </ul>\n" &
    "  </div>\n" &
    "  <div id=\"content\">\n" &
    "    " & $(content) & "\n" &
    "    A dollar: $.\n" &
    "  </div>\n" &
    "</body>\n")

type
  Person = ref object
    name: string
    age: int

macro getFiled(obj, field: untyped): NimNode = 
  result = newDotExpr(ident($obj), ident($field))

# template render(name: string, data: var untyped) = discard
proc render[T](name: string, data: var T) = 
  var html = "hogehoge {{.name}} fugafuga"
  echo "Age: ", getFiled("data", "age")
  echo html.replace(re"{{.+?}}", proc (m: string) : string =
    var field:string = m.replace(re"{{. *", "").replace( re" *}}", "")
    # getFiled("data", field)
    # data.name
    field
  )

routes:
  get "/":
    var person = Person(name: "enta", age: 23)
    render("hoge", person)
    resp generateHTMLPage("foo", "bar", "baz", ["bar"])

runForever()
