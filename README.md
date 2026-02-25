<h1>
	<img src="github/logo.svg" alt="tiniest">
</h1>

`tiniest` is a collection of minimal, portable testing libraries for Luau,
built on a few principles:

- Simple, idiomatic Luau throughout.
- Zero external dependencies.
- Small core, extend with plugins.
- Runtime independence.
- No opinions about project structure.

`tiniest` comes with pre-configured bundles for popular runtimes like Roblox and
Lune, or pick and mix your own modules and plugins!

## Features

- `test()` and `describe()` callbacks
- Clean, correctly-cropped stack traces
- Declarative `expect()` API with line numbers and code visualisation
- Pretty-formatted summaries of reports with emoji, Unicode, and colour
- Benchmark how long tests run for
- Extensible, lightweight plugin system
- Snapshot testing for all quotable data types

### Planned

- Test discovery for Lune

## Installation

No installation needed!

`tiniest` is distributed as a set of portable Luau files that sit next to each
other. Drop them into your `lib` folder, keep the ones you need, and start using
`tiniest` right away :)

### pesde

`tiniest` can also be installed from the pesde index:

```sh
pesde add storybakery/tiniest
```

For maintainers, the publish flow is:

```sh
pesde auth login

# 1) Lune target
# [target]
# environment = "lune"
# lib = "src/tiniest_for_lune.luau"
pesde publish --dry-run
pesde publish

# 2) Luau target (same name + same version)
# [target]
# environment = "luau"
# lib = "src/tiniest.luau"
pesde publish --dry-run
pesde publish

# 3) Roblox target (same name + same version)
# [target]
# environment = "roblox"
# lib = "src/tiniest_for_roblox.luau"
# build_files = ["src"]
pesde publish --dry-run
pesde publish
```

As of February 25, 2026, `pesde x jiwonz/multitarget` currently fails in this
setup with `could not resolve child component "GreenTea"`, so this repository
uses the sequential target publish flow above instead.

## Usage

> *🎨 The printed reports come with colour - try it in your terminal!*

Here's an example file written with `tiniest_for_lune`:

```Lua
--!strict

local tiniest = require("@tiniest_for_lune").configure({
	snapshot_path = "./test/__snapshots__",
	save_snapshots = true
}) 

local function my_test_suite()
	local describe = tiniest.describe
	local test = tiniest.test
	local expect = tiniest.expect
	local snapshot = tiniest.snapshot

	describe("some cool features", function()
		test("it works", function()
			expect(2 + 2).is(4)
		end)

		test("snapshots", function()
			snapshot({
				hello = "world",
				foo = true,
				bar = 2
			})
		end)
	end)
end

local tests = tiniest.collect_tests(my_test_suite)
tiniest.run_tests(tests, {})
```

The above example generates a report like this and prints it to stdout:

```
══════════════════════════════ Status of 2 test(s) ═════════════════════════════

✅ some cool features ▸ it works - 74.9µs
✅ some cool features ▸ snapshots - 137.71ms

══════════════════════════════ 2 passed, 0 failed ══════════════════════════════

Time to run: 217.9ms

════════════════════════════════════════════════════════════════════════════════
```

Failures look like this:

```
═════════════════════════════ Errors from 2 test(s) ════════════════════════════

❌ some cool features ▸ it works
Expectation not met
   │ 
16 │ expect(4).is(5)
   │ 
[string "test/test_main"]:16

❌ some cool features ▸ snapshots
Snapshot does not match
   │ 
78 │ snapshot({
   │   ["bar"] = 2;
   │   ["foo"] = true;
   │   ["hello"] = "world";
   │ })
   │ 
   │ -- snapshot on disk:
   │ snapshot({
   │   ["bar"] = 5;
   │   ["foo"] = false;
   │   ["hello"] = "earth";
   │ })
   │ 
[string "test/test_main"]:20

══════════════════════════════ Status of 2 test(s) ═════════════════════════════

❌ some cool features ▸ it works - 111.6ms
❌ some cool features ▸ snapshots - 174.9ms

══════════════════════════════ 0 passed, 2 failed ══════════════════════════════

Time to run: 292.81ms

════════════════════════════════════════════════════════════════════════════════
```

## License

Licensed the same way as all of my open source projects: BSD 3-Clause + Security Disclaimer.

As with all other projects, you accept responsibility for choosing and using this project.

See [LICENSE](./LICENSE) or [the license summary](https://github.com/dphfox/licence) for details.
