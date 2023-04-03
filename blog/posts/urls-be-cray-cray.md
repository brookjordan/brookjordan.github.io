# URLs be cray-cray

For example, who remembers that we don’t only have query/search params, but also path params?

No-one, that’s who. Because no-one uses them anymore. But any URL parser worth its salt understands a URL ending in `;param=value` should extract a path param of `param` with the value of… well… `value`.

## An extreme

This is pulled straight from [this website hosted by Talisman, originally from blog.lunatech](https://www.talisman.org/~erlkonig/misc/lunatech%5Ewhat-every-webdev-must-know-about-url-encoding/), and is something I often search for and take a long time to find:

### The reserved characters are not what you think they are

Most people ignore that "+" is allowed in a path part and that it designated the plus character and not a space. There are other surprises:

- "?" is allowed unescaped anywhere within a query part,
- "/" is allowed unescaped anywhere within a query part,
- "=" is allowed unescaped anywhere within a path parameter or query parameter value, and within a path segment,
- ":@-._~!$&'()*+,;=" are allowed unescaped anywhere within a path segment part,
- "/?:@-._~!$&'()*+,;=" are allowed unescaped anywhere within a fragment part.

While this is slightly nuts and [http://example.com/:@-._\~$!&'()\*+,=;:@-._\~$!&'()\*+,=:@-._\~$!&'()\*+,==?/?:@-._\~$!'()\*+,;=/?:@-._\~$!'()\*+,;==#/?:@-._\~$!&'()\*+,;=](http://example.com/:@-._~$!&'()*+,=;:@-._~$!&'()*+,=:@-._~$!&'()*+,==?/?:@-._~$!'()*+,;=/?:@-._~$!'()*+,;==#/?:@-._~$!&'()*+,;=*) is a valid HTTP URL, this is the standard.

For the curious, the previous URL expands to:

Part | Value
-- | --
Scheme | http
Host | example.com
Path | /:@-._~$!&'()*+,=
Path parameter name | :@-._~$!&'()*+,
Path parameter value | :@-._~$!&'()*+,==
Query parameter name | /?:@-._~$!'()* ,;
Query parameter value | /?:@-._~$!'()* ,;==
Fragment | /?:@-._~$!&'()*+,;=

Nuts.
