# contents.test.coffee

import {AvaTester} from '@jdeighan/ava-tester'
import {
	say, undef, setUnitTesting,
	} from '@jdeighan/coffee-utils'
import {loadEnvFrom} from '@jdeighan/env'
import {mydir, mkpath} from '@jdeighan/coffee-utils/fs'
import {getFileContents} from '@jdeighan/convert-utils'

setUnitTesting(true)
loadEnvFrom(mydir(`import.meta.url`), {
	rootName: 'dir_root',
	})
simple = new AvaTester()

# ---------------------------------------------------------------------------
# --- test getFileContents without conversion

simple.equal 20, getFileContents('file.md'), "Contents of file.md"

setUnitTesting(false)

simple.equal 24, getFileContents('file.md'), """
		title
		=====

		subtitle
		--------

		"""

simple.equal 33, getFileContents('file.taml'), """
		---
		-
			first: 1
			second: 2
		-
			kind: cmd
			cmd: include

		"""

simple.equal 44, getFileContents('file.txt'), """
		abc
		def

		"""

# ---------------------------------------------------------------------------
# --- test getFileContents with conversion

simple.equal 53, getFileContents('file.md', true), """
		<h1>title</h1>
		<h2>subtitle</h2>
		"""

simple.equal 58, getFileContents('file.taml', true), [
		{first: 1, second: 2},
		{kind: 'cmd', cmd: 'include'},
		]

simple.equal 63, getFileContents('file.txt', true), """
		abc
		def
		"""

setUnitTesting(true)

