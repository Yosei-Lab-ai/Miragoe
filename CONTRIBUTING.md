# Contributing to Lifestack

Thank you for your interest in contributing to Lifestack.

## How to Contribute

### Reporting Issues
- Open a GitHub issue describing the problem or suggestion
- Include which skill is affected and steps to reproduce

### Adding or Modifying Skills
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/skill-name`
3. Follow the skill structure in `docs/skills.md`
4. Test your skill manually with Claude Code
5. Submit a pull request

### Skill File Format
Each skill lives in its own directory with a `skill.md` file:

```
skill-name/
└── skill.md
```

The `skill.md` file uses Claude Code's skill format with YAML frontmatter:
- `name`: Slash command name
- `description`: One-line description for skill discovery
- Prompt body: Full instructions for Claude Code

### Writing Guidelines
- **Identity-first language**: Always frame in terms of identity, not just goals
- **Compassionate tone**: Direct and honest, never shaming
- **Evidence-based**: Ask for concrete evidence, not feelings
- **Actionable**: Every interaction should end with a next step

### Code of Conduct
- Be respectful and constructive
- Focus on the work, not the person
- The ethos of Lifestack applies to contributing too: compassionate confrontation

## Development Setup

```bash
git clone https://github.com/sho/lifestack.git
cd lifestack
bash setup
```

This creates symlinks to `~/.claude/skills/lifestack/` so you can test
skills immediately with Claude Code.

## Architecture Decisions
See [ARCHITECTURE.md](ARCHITECTURE.md) for technical details and data model.
See [ETHOS.md](ETHOS.md) for the design philosophy that guides all skills.
