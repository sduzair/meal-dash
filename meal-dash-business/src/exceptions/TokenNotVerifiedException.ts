export class TokenNotVerifiedException extends Error {
  public status: number;
  public message: string;
  public cookie: string;

  constructor(status: number, message: string, cookie: string) {
    super(message);
    this.status = status;
    this.message = message;
    this.cookie = cookie;
  }
}
