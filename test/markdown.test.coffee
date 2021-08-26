# markdown.test.coffee

import {AvaTester} from '@jdeighan/ava-tester'
import {
	say, undef, setUnitTesting,
	} from '@jdeighan/coffee-utils'
import {loadEnvFrom} from '@jdeighan/env'
import {mydir} from '@jdeighan/coffee-utils/fs'
import {markdownify} from '@jdeighan/convert-utils'

loadEnvFrom(mydir(`import.meta.url`), {
	rootName: 'dir_root',
	})
simple = new AvaTester()
setUnitTesting(false)

# ---------------------------------------------------------------------------

class MarkdownTester extends AvaTester

	transformValue: (text) ->

		return markdownify(text)

tester = new MarkdownTester()

# ---------------------------------------------------------------------------

(() ->

	tester.equal 31, """
			title
			=====
			""", """
			<h1>title</h1>
			"""

	tester.equal 38, """
			title
			-----
			""", """
			<h2>title</h2>
			"""

	tester.equal 45, """
		this is **bold** text
		""", """
		<p>this is <strong>bold</strong> text</p>
		"""

	tester.equal 51, """
		```javascript
				adapter: adapter({
					pages: 'build',
					assets: 'build',
					fallback: null,
					})
		```
		""", """
		<pre><code class="language-javascript"> adapter: adapter(&lbrace;
		pages: &#39;build&#39;,
		assets: &#39;build&#39;,
		fallback: null,
		&rbrace;)
		</code></pre>
		"""

	)()
