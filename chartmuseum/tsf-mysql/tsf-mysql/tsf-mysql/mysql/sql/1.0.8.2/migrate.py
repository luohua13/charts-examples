# coding: utf8

import MySQLdb
import requests
from MySQLdb.cursors import SSDictCursor

# 正式环境
# DB_HOST = '10.59.216.87'
# DB_PORT = 14145
# DB_USER = 'tsf_auth'
# DB_PASSWORD = 'Tcdn@2007'
# DB_NAME = 'tsf_auth'

# 测试环境
DB_HOST = '10.249.50.199'
DB_PORT = 16693
DB_USER = 'tsf_auth'
DB_PASSWORD = 'Tcdn@2007'
DB_NAME = 'tsf_auth'


def main():
    db = MySQLdb.connect(host=DB_HOST, port=DB_PORT, user=DB_USER, passwd=DB_PASSWORD, db=DB_NAME)
    cursor = db.cursor(SSDictCursor)
    cursor.execute("""
SELECT source_service_id, target_service_id, auth_type, namespace_id, app_id, uin, sub_account_uin
FROM tsf_auth_authorization""")
    rows = cursor.fetchall()

    info_by_target_services = {}
    for row in rows:
        info_by_target_services.setdefault(row['target_service_id'], {
            'source_service_ids': [],
            'auth_type': row['auth_type'],
            'namespace_id': row['namespace_id'],
            'app_id': row['app_id'],
            'uin': row['uin'],
            'sub_account_uin': row['sub_account_uin'],
        })
        info_by_target_services[row['target_service_id']]['source_service_ids'].append(row['source_service_id'])

    for target_service_id, info in info_by_target_services.items():
        data = {
            'isEnabled': True,
            'targetServiceId': target_service_id,
            'appId': info['app_id'],
            'uin': info['uin'],
            'subAccountUin': info['sub_account_uin'],
            'namespaceId': info['namespace_id'],
            'conditions': [
                {
                    'type': 'meta',
                    'key': 'source.service.id',
                    'operator': 'in' if info['auth_type'] == 'W' else 'notIn',
                    'valueList': info['source_service_ids'],
                }
            ]
        }
        print("Syncing service {} with data: \n{}".format(target_service_id, data))
        # r = requests.post("http://127.0.0.1:12000/authorization/update", json=data)
        r = requests.post("http://10.53.87.4:12000/authorization/update", json=data)
        if r.status_code != 200:
            print("Failed, {} {}".format(r.status_code, r.content))
        else:
            print("Success")
        print('')


if __name__ == '__main__':
    main()
