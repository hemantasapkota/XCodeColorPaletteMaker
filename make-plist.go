package main

import (
  "fmt"
  "io/ioutil"
  "strings"
  "os"
  )

func main() {

  b, err := ioutil.ReadFile("flat_colors.list")
  if err != nil {
    panic("End of the world")
    os.Exit(1)
  }

  strbuffer := string(b)
  arr := strings.Split(strbuffer, "\n")

  for _, v := range arr {
    val := strings.Split(v, ":")
    if len(val) > 1 {
      fmt.Printf("<key>%s</key>\n<string>%s</string>\n", strings.TrimSpace(val[0]), strings.TrimSpace(val[1]))
    }
  }
}
