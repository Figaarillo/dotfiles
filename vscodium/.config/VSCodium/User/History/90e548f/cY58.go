package utils

import (
	"os"
	"os/signal"
)


func StartServerWithGracefulShutdown(app *fiber.App) {
	idleConnsClosed := make(chan struct{})

	go func() {
		sigint := make(chan os.Signal, 1)
		signal.NNotify()
	}
}
