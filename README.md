# Sutra UI

<p align="center">
  <img src="[path-to-your-logo]" alt="Sutra UI Logo" width="200"/>
</p>

<p align="center">
  <a href="https://hex.pm/packages/sutra_ui"><img alt="Hex Version" src="https://img.shields.io/hexpm/v/sutra_ui.svg"/></a>
  <a href="https://hexdocs.pm/sutra_ui"><img alt="Hex Docs" src="https://img.shields.io/badge/hex-docs-lightgreen.svg"/></a>
  <a href="https://opensource.org/licenses/MIT"><img alt="MIT License" src="https://img.shields.io/badge/License-MIT-blue.svg"/></a>
</p>

> "Sutra" means rules in Sanskrit - we define the rules so you don't have to.

Sutra UI is a comprehensive Phoenix LiveView component library designed to provide rich, interactive UI elements out of the box. Built for developers who want to create beautiful, functional web applications without reinventing the wheel.

## Features

- 🎨 Beautifully designed components
- ⚡️ Built for Phoenix LiveView
- 🛠 Easy to customize
- 📱 Responsive by default
- 🔧 Advanced functionality components

## Installation

Add `sutra_ui` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:sutra_ui, "~> 0.1.0"}
  ]
end
```

## Available Components

- Avatar & Avatar Group
- Breadcrumb
- Button
- Chip
- Dropdown (with Popper.js integration)
- Input (with form validations)
- Modal
- Offcanvas
- Tabs
- Flash (coming soon)
- Advanced DataTable (coming soon)

## Usage

### Basic Example

```elixir
<.button color="primary" phx-click="save">
  Save Changes
</.button>

<.input
  type="text"
  name="username"
  label="Username"
  placeholder="Enter username"
/>
```

[More detailed component examples to be added]

## Advanced Components (Coming Soon)

### DataTable
- Built-in filtering
- Sorting capabilities
- Export to CSV/PDF
- Pagination
- Custom column rendering

## Requirements

- Phoenix LiveView (latest version)
- Phoenix Framework (latest version)
- Elixir (latest version)

## Dependencies

- Popper.js (for tooltips and dropdowns)
- Tippy.js (for enhanced positioning)

## Contributing

We love contributions! There are several ways you can help improve Sutra UI:

1. Fix existing bugs or UI improvements
2. Work on items from our todo list
3. Suggest and implement new components
4. Improve documentation

Please feel free to submit issues and pull requests.

### Todo List

- [ ] Flash component implementation
- [ ] Advanced DataTable with filtering and export capabilities
- [ ] More component variations and themes
- [ ] Additional documentation and examples

## License

MIT License. See [LICENSE](LICENSE) for more information.

## Credits

Created and maintained by [Gurujada].

## Screenshots

[Coming Soon]
