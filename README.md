# HDI_ListboxProperties

A 4D v17 **HDI** (How Do I) binary database converted to a 4D project using 4D 21. The codebase was then modernised with the help of **GitHub Copilot**.

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D {version}. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool, then modernised (see below) for current 4D language and platform conventions.

- **Blog post:** https://blog.4d.com/listbox-more-programming-possibilities/
- **Original download:** https://download.4d.com/Demos/4D_v16_R2/HDI_ListboxProperties.zip

## What This Example Demonstrates

The demo is an exhaustive, side-by-side catalogue of list box `SET`/`GET` properties, arranged as ~25 small list boxes on one scrolling form (`HDI2`), each isolating a single property or property pair:

- **Column sizing** — `Min Width` / `Max Width` at both the column and list box level, and the effect of `resizable`.
- **Truncation** — `truncateMode` (with/without ellipsis) at the column and list box level.
- **Resizing behaviour** — `resizingMode` (legacy "last column grows" vs. proportional).
- **Row/header/footer visibility and sizing** — show/hide header, footer, and row height in points vs. lines.
- **Alternate row and cell styling** — background color, font color, and font style driven by a per-row meta-expression (`SetColor`), plus multi-style (bold/italic/underline) columns.
- **Selection and highlighting** — named selections (`Selection name`), highlight sets, and single vs. multiple selection mode.
- **Checkboxes and numeric display** — three-state checkboxes vs. plain numeric format for boolean/numeric columns.
- **Sorting** — enabling/disabling column sort, per column and for the whole list box.
- **Scrollbars** — horizontal/vertical scrollbar width and height.
- **Detail form** — associating and opening a detail form from a list box row (`Detail form name`, `Edit record` / `Display record` / `Do nothing`).

Each panel has paired **SET**/**GET** buttons so a developer can change a property at runtime and immediately read back the resulting value — a live reference for the corresponding `LISTBOX SET PROPERTY` / `LISTBOX Get property` commands.

## Modernisation Highlights

This branch brought the project in line with current 4D project-mode conventions. Each area is backed by a corresponding instruction file under `.github/instructions/`:

| Area | What changed |
|------|--------------|
| **Localisation (XLIFF)** | All menu titles, form text/labels, and message strings resolve through `:xliff:` references or `Localized string(...)`, backed by `Resources/{lang}.lproj/*.xlf` files for every supported language, including the source language (`en.lproj`, added alongside the existing `ja.lproj`). |
| **Variable declarations** | Deprecated `C_LONGINT`/`C_TEXT`/`C_OBJECT`/etc. directives replaced project-wide with `var`/`#DECLARE` syntax, across project methods, form methods, and all ~98 list box object methods. |
| **Menu actions** | The legacy one-line `m_Quit` method wrapper was removed; `menus.json` already used the built-in `"action": "quit"` standard action, so Quit gets native platform integration instead of a raw `QUIT 4D` call. |
| **Method visibility** | The `SetColor` meta-expression subroutine is marked `"invisible":true` (it's only ever invoked via a string formula from list box color/style expressions, never standalone); the `00_Start` entry point stays visible. |
| **Startup dialog pattern** | The splash screen (`00_Start` / `HDI` form) now uses `#DECLARE`, `CALL WORKER` instead of `New process`, a non-blocking `DIALOG(...; *)`, window-reuse detection instead of opening duplicate splash windows, and `Form.quit`-based state instead of interprocess variables. |
| **Dark mode & Liquid Glass** | `styleSheets.css` uses `"automatic"`/`"automaticAlternate"` colour values so text, backgrounds, and the list box's alternate rows adapt to light/dark mode. `styleSheets_mac.css` sets Liquid Glass-appropriate button heights (27px vs. 23px classic) via `form-theme` media queries, applied to all 98 buttons across both forms. |
| **List box display defaults** | Every list box column across all ~25 list boxes uses `"truncateMode": "none"` (no mid-word ellipsis truncation) and every list box uses `"resizingMode": "legacy"` (last column grows) unless it is itself the subject of that specific demo panel. |

## Points of Interest

- **`SetColor.4dm`** — a per-row meta-expression subroutine that derives background colour, font colour, and font style from the current record's position in the selection (via `Cos`/rotating hue angles), showing how a single string-formula callback (`"SetColor(\"background\")"`) can drive dynamic, per-row list box styling.
- **CSS specificity in 4D forms** — properties set directly in `.4DForm` JSON always win over CSS. Colours and button heights had to be *removed* from the JSON (and a `"class"` added) before `styleSheets*.css` rules could take effect; see `.github/instructions/css.instructions.md`.
- **4D CSS `form-theme` media queries** — `@media (form-theme: liquid-glass)` / `@media (form-theme: mac-classic)` let a single stylesheet target macOS Tahoe's Liquid Glass look and older/classic rendering side by side, defined on both `.default` and `button.default` selectors for reliable matching.
- **Token safety in project-mode source** — `.4dm` files may contain optional `:CNNN` command tokens. This project's convention (and this modernisation pass) is to never guess a token; only include one if it's already verified elsewhere in the source, otherwise omit it and let 4D re-resolve the plain name.
- **Form-scoped state over interprocess variables** — the splash-to-demo transition passes state via the `Form` object (e.g. `Form.quit`) rather than interprocess variables, keeping each window's state isolated.
- **Legacy XLIFF 1.0 dialect** — this project's existing `.xlf` files predate the XLIFF 1.2 grouping style; entries use the literal English source text as the `resname` (rather than an arbitrary ID). That existing house convention was preserved for consistency instead of reformatting, since it's a real working pattern already backing hundreds of translated strings.

## Project Structure

```
Project/Sources/
  Methods/                Project methods (00_Start, SetColor)
  Forms/HDI/               Splash screen form + BtnDemo object method
  Forms/HDI2/              Main demo form: ~25 list boxes, ~98 SET/GET button object methods
  menus.json               Menu bar definition
  styleSheets.css           Cross-platform colours (dark mode / automatic values)
  styleSheets_mac.css       macOS-specific rules (Liquid Glass button heights)
Resources/
  en.lproj/, ja.lproj/      XLIFF translation files (English source + Japanese)
```

## References

- `LISTBOX SET PROPERTY`: https://developer.4d.com/docs/commands/listbox-set-property
- `LISTBOX Get property`: https://developer.4d.com/docs/commands/listbox-get-property
- List Box Column properties: https://developer.4d.com/docs/FormObjects/listbox-column
- Resizing options: https://developer.4d.com/docs/FormObjects/propertiesResizingOptions
- CSS in 4D forms: https://developer.4d.com/docs/FormEditor/stylesheets
- Liquid Glass in 4D: https://blog.4d.com/the-new-macos-tahoe-design-comes-to-your-4d-applications/
- XLIFF localisation in 4D: https://developer.4d.com/docs/Notions/localization
