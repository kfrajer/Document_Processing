
## TO START

export AWS_PROFILE=confoo
export TF_VAR_LOCAL_AWS_PROFILE="${AWS_PROFILE}"




## SAMPLE OUTPUTS

================ FROM Document_Processing/textract_A2I/terraform

cmosquer@CMOSQUER-M-Q4XC terraform % pwd
/Users/cmosquer/Workspace/ads/Tf/Document_Processing/textract_A2I/terraform

Apply complete! Resources: 39 added, 0 changed, 0 destroyed.

Outputs:

s3_bucket_processed_arn = "arn:aws:s3:::document-processor-ml-cmos-processed-documents"
s3_bucket_raw_arn = "arn:aws:s3:::document-processor-ml-cmos-raw-documents"
sns_topic_arn = "arn:aws:sns:us-east-1:924300192870:AmazonTextract-document-processor-ml-cmos-results"
sqs_queue_arn = "arn:aws:sqs:us-east-1:924300192870:document-processor-ml-cmos-trigger-textract"
textract_results_queue_arn = "arn:aws:sqs:us-east-1:924300192870:document-processor-ml-cmos-textract-process"



================ FROM Document_Processing/genai/terraform

cmosquer@CMOSQUER-M-Q4XC terraform % pwd
/Users/cmosquer/Workspace/ads/Tf/Document_Processing/genai/terraform

Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

s3_bucket_processed_arn = "arn:aws:s3:::document-processor-ai-cmos-processed-documents"
s3_bucket_raw_arn = "arn:aws:s3:::document-processor-ai-cmos-raw-documents"
sqs_queue_arn = "arn:aws:sqs:us-west-2:924300192870:document-processor-ai-cmos-trigger-textract"


### SAMPLE output processing a document:
```json
{
  "Invoice Number": "2170",
  "Invoice Date": "2017/09/29",
  "Due Date": "",
  "Vendor Name": "robopro",
  "Vendor Address": "1 Main Road, Johannesburg, South Africa",
  "Vendor Phone Number": "",
  "Vendor Email": "leon@robopro.co",
  "Total Amount": "1725,00",
  "Currency": "$",
  "Line Items": [
    {
      "quantity": "6",
      "description": "Service Fee",
      "price": "200,00",
      "amount": "1200,00"
    },
    {
      "quantity": "7",
      "description": "Additional Services",
      "price": "75,00",
      "amount": "525,00"
    }
  ]
}
```


## ERRORS DURING EXECUTION for genai case:


### First

Error calling Bedrock: An error occurred (AccessDeniedException) when calling the InvokeModel operation: You don't have access to the model with the specified model ID.

Resolved by: Reviewing this stackoverflow: https://stackoverflow.com/questions/78043994/aws-langchain-tutorial-access-request-to-aws-bedrock-model-fails-with-operatio

### Second

Error calling Bedrock: An error occurred (ValidationException) when calling the InvokeModel operation: Invocation of model ID anthropic.claude-3-7-sonnet-20250219-v1:0 with on-demand throughput isn’t supported. Retry your request with the ID or ARN of an inference profile that contains this model.

Resolved by: Reviewing this quick start: https://community.aws/content/2tXkZKrZzlrlu0KfH8gST5Dkppq/claude-code-on-amazon-bedrock-quick-setup-guide?lang=en
Using the right ID, not the one from the Bedrock Model UI but to mimic the documentation

