package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"time"
	"github.com/gdamore/tcell/v2"

	"github.com/rivo/tview"
)

var (
	app      *tview.Application
	textView *tview.TextView
)

type Payload struct {
	Value string `json:"value"`
}

func getAndDrawJoke() {
	// Fetch a Chuck Norris joke from the API
	resp, err := http.Get("https://api.chucknorris.io/jokes/random")
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	payloadBytes, err := io.ReadAll(resp.Body)
	if err != nil {
		panic(err)
	}

	payload := &Payload{}
	err = json.Unmarshal(payloadBytes, payload)
	if err != nil {
		panic(err)
	}

	// Update the UI with the joke
	textView.Clear()
	timeStr := fmt.Sprintf("[gray]%s[-]", time.Now().Format(time.RFC1123)) 
	textView.SetTitle("Chuck Norris Joke Generator")                      
	textView.SetText(fmt.Sprintf("%s\n\n[white]%s[-]", timeStr, payload.Value)) 
}

func refreshJoke() {
	ticker := time.NewTicker(14 * time.Second)
	defer ticker.Stop()

	for {
		select {
		case <-ticker.C:
			getAndDrawJoke()
			app.Draw()
		}
	}
}

func main() {
	// Initialize the global variables
	app = tview.NewApplication()
	textView = tview.NewTextView().
		SetDynamicColors(true).
		SetWrap(true).
		SetWordWrap(true).
		SetTextAlign(tview.AlignCenter).
		SetTextColor(tcell.ColorLime).
		SetText("Hello, world! From Tview!")

	// Start refreshing jokes in the background
	getAndDrawJoke()
	go refreshJoke()

	// Run the application
	if err := app.SetRoot(textView, true).Run(); err != nil {
		panic(err)
	}
}
