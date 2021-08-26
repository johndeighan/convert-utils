# sass.test.coffee

import {AvaTester} from '@jdeighan/ava-tester'
import {
	say, undef, setUnitTesting,
	} from '@jdeighan/coffee-utils'
import {loadEnvFrom} from '@jdeighan/env'
import {mydir} from '@jdeighan/coffee-utils/fs'
import {sassify} from '@jdeighan/convert-utils'

loadEnvFrom(mydir(`import.meta.url`), {
	rootName: 'dir_root',
	})
simple = new AvaTester()
setUnitTesting(true)

# ---------------------------------------------------------------------------

class SassTester extends AvaTester

	transformValue: (text) ->

		return sassify(text)

tester = new SassTester()

# ---------------------------------------------------------------------------

(() ->

	tester.equal 30, """
	# --- This is a red paragraph (this should be removed)
	p
		margin: 0
		span
			# --- this is also a comment
			color: red
	""", """
	p
		margin: 0
		span
			color: red
	"""

	)()

# ---------------------------------------------------------------------------

setUnitTesting false

(() ->

	tester.equal 51, """
	# --- here, we should use the real sass processor
	p
		margin: 0
		span
			color: red
	""", """
	p {
		margin: 0;
	}
	p span {
		color: red;
	}
	"""
	)()

# ---------------------------------------------------------------------------
