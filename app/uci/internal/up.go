package internal

import "github.com/spf13/cobra"

var UpCmd = &cobra.Command{
	Use:   "up",
	Short: "start a shim for messaging",
	Long:  "start a shim for messaging",
	Run: func(cmd *cobra.Command, args []string) {

	},
}
