import { IOrganization } from './interfaces';

function validate_organization(org:IOrganization): IOrganization | null {
  let failed = false;

  const required_fields = [
    'identifier',
    'businessName',
    'dba',
    'ein',
    'businessCity'
  ];

  const validatedOrg: IOrganization = {
    identifier: '',
    businessName: '',
    dba: '',
    ein: '',
    businessCity: ''
  };

  required_fields.forEach((field: string) => {
    if (failed) return;

    if (typeof org[field] !== 'string' || org[field] === '') {
      failed = true;

      return;
    }

    validatedOrg[field] = org[field];
  });

  if (failed) return null;

  return validatedOrg;
}

export {
  validate_organization
}
