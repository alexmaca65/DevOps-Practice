import json
import boto3

pricing_client = boto3.client('pricing', region_name='us-east-1')


def get_products(region):
    paginator = pricing_client.get_paginator('get_products')

    response_iterator = paginator.paginate(
        ServiceCode="AmazonEC2",
        Filters=[
            {
                'Type': 'TERM_MATCH',
                'Field': 'location',
                'Value': region
            },
            {
                'Type': 'TERM_MATCH',
                'Field': 'instanceType',
                'Value': 'm5.large'
            },
            {
                'Type': 'TERM_MATCH',
                'Field': 'capacitystatus',
                'Value': 'Used'
            },
            {
                'Type': 'TERM_MATCH',
                'Field': 'tenancy',
                'Value': 'Shared'
            },
            {
                'Type': 'TERM_MATCH',
                'Field': 'preInstalledSw',
                'Value': 'NA'
            },
            {
                'Type': 'TERM_MATCH',
                'Field': 'operatingSystem',
                'Value': 'Linux'
            }
        ],
        PaginationConfig={
            'PageSize': 100
        }
    )

    products = []
    for response in response_iterator:
        for priceItem in response["PriceList"]:
            priceItemJson = json.loads(priceItem)
            products.append(priceItemJson)

    print(products)


if __name__ == '__main__':
    get_products('EU (Ireland)')
