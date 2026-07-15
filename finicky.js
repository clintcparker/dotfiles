// Finicky config
// Docs: https://github.com/johnste/finicky/wiki/Configuration
export default {
    defaultBrowser: "Browserosaurus",
    handlers: [
      {
        match: (url) => url.host === "meet.google.com",
        browser: "Google Meet"
      },
      {
        match: url => url.host === "localhost",
        browser: "Firefox Developer Edition"
      },
      {
        match: (_url, { opener }) => ["Gmail","Google Calendar","Google Meet","ClockShark - Slack","Limitless","Zoom"].includes(opener?.name),
        browser: {
          name: "Microsoft Edge",
          profile: "Profile 1"
        }
      },
      {
        match: (_url, { opener }) => ["FMail2", "Messages", "OneDrive"].includes(opener?.name),
        browser: {
          name: "Firefox",
        }
      }
    ]
  }
