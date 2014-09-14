dante Cookbook
==============
Dante is opensource socks proxy and this cookbook provides the functionality to install it.

Requirements
------------

#### packages
- `build-essential` - dante is installed from source so that gcc, make and other build tools are required.

Attributes
----------

#### dante::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['dante']['version']</tt></td>
    <td>String</td>
    <td>the version you want to install</td>
    <td><tt>1.4.1</tt></td>
  </tr>
  <tr>
    <td><tt>['dante']['checksum']</tt></td>
    <td>String</td>
    <td>expected checksum of download file</td>
    <td><tt>See attributes/default.rb</tt></td>
  </tr>
</table>

Usage
-----
#### dante::default

Just include `dante` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[dante]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
License: MIT License

Authors: Ryutaro YOSHIBA
