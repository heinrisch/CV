package hello

import (
  "fmt"
  "net/http"
  "encoding/json"
  "bufio"
  "os"
  "strings"
)

func init() {
  http.HandleFunc("/", mainHandler)
  http.HandleFunc("/experience", experienceHandler)
  http.HandleFunc("/education", educationHandler)
}

func mainHandler(w http.ResponseWriter, r *http.Request) {
  fmt.Fprint(w, "Noting to see here...")
}

type Experience struct {
    ID string `json:"id"`
    Title string `json:"title"`
    Description string `json:"description"`
    Longdescription string `json:"longdescription"`
    Period string `json:"period"`
}


func experienceHandler(w http.ResponseWriter, r *http.Request) {
  outputFileToJson(w, r, "cv/experience.txt")
}

func educationHandler(w http.ResponseWriter, r *http.Request) {
  outputFileToJson(w, r, "cv/education.txt")
}

func outputFileToJson(w http.ResponseWriter, r *http.Request, filePath string) {
  var(
    file *os.File
    line string
    items []Experience
  )

  file, err := os.Open(filePath)

  if err != nil {
    fmt.Fprint(w, "error:", err)
  }

  reader := bufio.NewReader(file)

  var lines []string
  for {
    if line, err = reader.ReadString('\n'); err != nil {
      items = append(items, experienceFromLines(lines))
      lines = make([]string, 0)
      break
    }
    if strings.TrimSpace(line) != "" {
      lines = append(lines, line)
    } else {
      items = append(items, experienceFromLines(lines))
      lines = make([]string, 0)
    }
  }

  json2, err2 := json.Marshal(items)
  if err2 != nil {
        fmt.Fprint(w, "error:", err2)
  }

  w.Header().Set("Access-Control-Allow-Origin", "*")
  fmt.Fprint(w,string(json2))
}

func experienceFromLines(lines []string) (Experience){
  return Experience{strings.Replace(strings.ToLower(lines[0]), " ", "", -1), lines[0], lines[1], lines[2], lines[3]}
}


