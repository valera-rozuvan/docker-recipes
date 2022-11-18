interface IStringsObject {
  [propName: string]: string;
}

interface IOrganization extends IStringsObject {
  identifier: string;
  businessName: string;
  dba: string;
  ein: string;
  businessCity: string;
}

interface IPingResponse {
  [propName: string]: string | number | undefined | null;
}

export {
  IOrganization,
  IPingResponse
};
