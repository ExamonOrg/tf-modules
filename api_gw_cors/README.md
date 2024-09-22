# Terraform AWS API Gateway CORS

A Terraform module to attach OPTIONS method to **ALL** the endpoints of an API Gateway to enable CORS (Cross-Origin Resource
Sharing) preflight requests.

## Usage

```hcl
module "cors" {
  source = "github.com/fundingcircle/terraform-aws-api-gateway-cors?ref=1.0.0"

  api_gateway_rest_api = <aws_api_gateway_rest_api.your_rest_api>
}
```

This module will create a new `proxy+` endpoint in your API Gateway and will attach OPTIONS method on it, so that CORS preflight requests will be allowed for ALL the other pre-existing endpoints by default.

## Configuration

The following variables can be configured:

### Required

#### `api_gateway_rest_api`

- **Description**: The Rest API gateway resource
- **Default**: `none`

### Optional

#### `allowed_headers`

- **Description**: Allowed headers
- **Default**: `Content-Type,Authorization,Accept,X-Amz-Date,X-Amz-Security-Token,X-Api-Key,X-Requested-With,traceparent`

#### `allowed_methods`

- **Description**: Allowed methods
- **Default**: `ANY`

#### `allowed_origin`

- **Description**: Allowed origin
- **Default**: `*`

#### `allow_credentials`

- **Description**: Allow credentials
- **Default**: `true`

#### `cache_max_age`

- **Description**: Response cache time in seconds
- **Default**: `7200`

## License

### BSD-3 License

Copyright (c) 2022 Funding Circle

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
