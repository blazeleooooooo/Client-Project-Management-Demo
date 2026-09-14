const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-8][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

export function isStaffUuid(value: string | null | undefined): boolean {
  return !!value && UUID_RE.test(value.trim());
}

export function isPlaceholderStaff(row: {
  id?: string | null;
  display_name?: string | null;
} | null | undefined): boolean {
  if (!row) return false;
  const name = (row.display_name || '').trim().toLowerCase();
  return name.includes('(manual)');
}

export function remapStaleStaffUuid(value: string | null | undefined): string {
  return (value || '').trim();
}

export function chooseStaffUuid(options: {
  loginStaffId?: string | null;
  sessionStaffId?: string | null;
}): string | null {
  const login = remapStaleStaffUuid(options.loginStaffId);
  if (isStaffUuid(login)) return login;

  const session = remapStaleStaffUuid(options.sessionStaffId);
  if (isStaffUuid(session)) return session;

  return null;
}

export function localDateString(d = new Date()): string {
  const year = d.getFullYear();
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  return `${year}-${month}-${day}`;
}
