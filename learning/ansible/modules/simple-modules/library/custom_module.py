#!/usr/bin/python

from ansible.module_utils.basic import AnsibleModule

def main():
    module = AnsibleModule(
        argument_spec=dict(
            name=dict(type='str', required=True),
            state=dict(type='str', choices=['present', 'absent'], required=True)
        )
    )

    name = module.params['name']
    state = module.params['state']

    result = {}

    if state == 'present':
        result['message'] = f"Hello, {name}!"
    else:
        result['message'] = f"Goodbye, {name}!"

    module.exit_json(changed=True, result=result)

if __name__ == '__main__':
    main()