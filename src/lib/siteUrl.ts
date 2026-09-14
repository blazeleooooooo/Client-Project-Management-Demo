export const CANONICAL_SITE_URL =
  typeof window === 'undefined' ? 'http://localhost:5173' : window.location.origin;

export const getSiteOrigin = (): string => {
  if (typeof window === 'undefined') return CANONICAL_SITE_URL;
  return window.location.origin;
};

export const redirectFromLegacyHost = () => {
  // Demo build never redirects to a production host.
};
