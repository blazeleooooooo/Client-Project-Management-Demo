import { useEffect, useState } from 'react';
import { useAuth } from '@/context/AuthContext';
import { Shield, AlertCircle } from 'lucide-react';

const EMAIL_HISTORY_KEY = 'mps_demo_email_history';

function loadEmailHistory(): string[] {
  try {
    const raw = localStorage.getItem(EMAIL_HISTORY_KEY);
    return raw ? (JSON.parse(raw) as string[]) : [];
  } catch {
    return [];
  }
}

function saveEmailToHistory(email: string) {
  try {
    const existing = loadEmailHistory().filter(e => e.toLowerCase() !== email.toLowerCase());
    const next = [email, ...existing].slice(0, 10);
    localStorage.setItem(EMAIL_HISTORY_KEY, JSON.stringify(next));
  } catch {
    /* ignore */
  }
}

export function LoginPage({ authError }: { authError?: string | null }) {
  const { signInWithEmailPhone } = useAuth();
  const [error, setError] = useState('');
  const [email, setEmail] = useState('demo@example.com');
  const [phone, setPhone] = useState('5551234');
  const [emailLoading, setEmailLoading] = useState(false);
  const [emailHistory, setEmailHistory] = useState<string[]>([]);

  useEffect(() => {
    setEmailHistory(loadEmailHistory());
  }, []);

  const handleEmailPhoneLogin = async () => {
    if (!email.trim() || !phone.trim()) {
      setError('Please enter email and phone password');
      return;
    }
    setEmailLoading(true);
    setError('');
    try {
      const trimmed = email.trim();
      await signInWithEmailPhone(trimmed, phone);
      saveEmailToHistory(trimmed);
      setEmailHistory(loadEmailHistory());
    } catch (err: any) {
      console.error('Email/phone login failed:', err);
      setError(err.message || 'Sign-in failed');
    } finally {
      setEmailLoading(false);
    }
  };

  const displayError = authError || error;

  return (
    <div className="min-h-screen bg-[#f5f8fc] flex items-center justify-center p-4">
      <div className="w-full max-w-[420px]">
        <div className="text-center mb-8">
          <div className="inline-flex items-center justify-center w-16 h-16 bg-teal-600 rounded-xl mb-4">
            <Shield size={28} className="text-white" />
          </div>
          <h1 className="text-[28px] font-extrabold tracking-tight text-[#0d1a2d]">Acme Marketing OS</h1>
          <p className="text-[14px] text-muted-foreground mt-1">Demo — synthetic data only</p>
        </div>

        <div className="bg-white rounded-lg border border-[rgba(13,26,45,0.08)] shadow-[0_2px_6px_rgba(0,20,40,0.05)] p-8">
          <h2 className="text-[20px] font-bold text-center mb-2">Sign in</h2>
          <p className="text-[13px] text-muted-foreground text-center mb-6">
            Use the seeded demo account below
          </p>

          {displayError && (
            <div className="flex items-start gap-3 p-4 bg-rose-50 border border-rose-300 rounded-lg mb-4 shadow-sm">
              <AlertCircle size={18} className="text-rose-600 shrink-0 mt-0.5" />
              <p className="text-[13px] font-medium text-rose-800 leading-relaxed">{displayError}</p>
            </div>
          )}

          <form
            className="space-y-3"
            onSubmit={(e) => { e.preventDefault(); void handleEmailPhoneLogin(); }}
          >
            <input
              type="email"
              name="email"
              autoComplete="email"
              list="login-email-history"
              placeholder="Email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full px-3 py-2.5 border border-border rounded-lg text-[13px] bg-white focus:outline-none focus:ring-2 focus:ring-teal-400 focus:border-teal-400"
            />
            <datalist id="login-email-history">
              {emailHistory.map(em => <option key={em} value={em} />)}
            </datalist>
            <input
              type="tel"
              name="phone"
              autoComplete="tel"
              placeholder="Phone password"
              value={phone}
              onChange={(e) => setPhone(e.target.value)}
              className="w-full px-3 py-2.5 border border-border rounded-lg text-[13px] bg-white focus:outline-none focus:ring-2 focus:ring-teal-400 focus:border-teal-400"
            />
            <button
              type="submit"
              disabled={emailLoading || !email.trim() || !phone.trim()}
              className="w-full px-4 py-2.5 bg-teal-600 text-white rounded-lg text-[13px] font-medium hover:bg-teal-700 transition-all disabled:opacity-50 disabled:cursor-not-allowed"
            >
              {emailLoading ? 'Signing in…' : 'Sign in'}
            </button>
          </form>

          <div className="mt-6 pt-5 border-t border-border/50">
            <p className="text-[11px] text-muted-foreground text-center leading-relaxed">
              Demo login: <span className="font-medium">demo@example.com</span> / phone <span className="font-medium">5551234</span>
            </p>
          </div>
        </div>

        <p className="text-[11px] text-muted-foreground text-center mt-6">
          © {new Date().getFullYear()} Acme Corp. Isolated demo — no production data.
        </p>
      </div>
    </div>
  );
}
