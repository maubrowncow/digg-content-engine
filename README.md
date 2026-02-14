# Digg Content Engine

Multi-persona content system for driving engagement on Digg through authentic, researched content and comments.

## Structure

```
digg-content-engine/
├── scripts/
│   └── clean-for-paste.ps1    # Sanitize text for web pasting
├── personas/
│   └── dustyballjoint/        # First persona
│       ├── PERSONA.md         # Identity & voice
│       ├── BOOKSHELF.md       # Domain knowledge (books)
│       ├── POST-HISTORY.md    # Engagement tracker
│       └── posts/             # Ready-to-post content
└── README.md
```

## Adding a Persona

1. Create folder: `personas/<username>/`
2. Add `PERSONA.md` with identity, voice, backstory
3. Add domain knowledge files (BOOKSHELF.md, GAMES.md, etc.)
4. Add `POST-HISTORY.md` to track engagement
5. Create `posts/` folder for ready content

## Clean Paste Script

Before pasting to Digg, run the clean script to remove invisible characters:

```powershell
.\scripts\clean-for-paste.ps1 -Path "personas\dustyballjoint\posts\001-audiobooks.md"
```

This removes:
- Non-breaking spaces (U+00A0)
- Zero-width characters
- Windows line endings (CRLF → LF)
- Trailing whitespace

Result is copied to clipboard, ready to paste.

## Workflow

1. Research community (Reddit/Twitter trends)
2. Draft post in persona's voice
3. Run clean-for-paste script
4. Post to Digg
5. Engage with comments using prepared responses
6. Log results in POST-HISTORY.md

---

*Created: 2026-02-14*
