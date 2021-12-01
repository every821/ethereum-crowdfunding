from brownie import config,FundMe,accounts



def deploy_contract():
    acc = accounts.add(config['wallets']['key']['private_key'])
    print(acc)
    FM= FundMe.deploy({'from':acc})
    print(FM.address)


def call_view_price():
    fm = FundMe[-1]
    price = fm.getPrice()
    print(price)


def send_fund(amount):
    acc = accounts.add(config['wallets']['key']['private_key_3'])
    fm = FundMe[-1]
    fund_tran=fm.fund({'from':acc,'value':amount})
    fund_tran.wait(1)
    print('Fund Transaction Complete')



def main():
    print('Code Start..')
    send_fund(5000000000000000)