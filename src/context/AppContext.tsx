import React, { createContext, useContext, useState, useMemo, ReactNode, useCallback, useEffect } from 'react';
import { User, UserRole } from '@/types/app';
import { useAuth } from '@/context/AuthContext';
import { isQuotationSectionModule } from '@/lib/quotationSectionScope';
import { beginPageNavigation } from '@/lib/supabaseFetch';

export interface SubMenuItem {
  id: string;
  label: string;
  /** Optional sidebar section heading (Traditional Chinese) */
  section?: string;
}

export function resolveSubModule(module: string, sub?: string): string {
  const menuItem = mainMenuItems.find(m => m.id === module);
  const defaultSub = menuItem?.subMenus[0]?.id || 'overview';
  if (!sub) return isQuotationSectionModule(module) ? 'pitching' : defaultSub;
  // Legacy alias: 影片管理 → 影片統籌
  if (module === 'video' && sub === 'management') return 'coordination';
  // Legacy alias: Google / Facebook Ads 同步 → 廣告數據同步
  if (module === 'marketing' && (sub === 'google-ads-sync' || sub === 'facebook-ads-sync')) {
    return 'ads-data-sync';
  }
  return menuItem?.subMenus.some(s => s.id === sub) ? sub : defaultSub;
}

/** Resolve module + submenu, including hashes that moved to another top-level item. */
export function resolveRoute(module: string, sub?: string): { module: string; subModule: string } {
  // Legacy: 平面設計 was under 行銷管理 (#marketing/graphic-design)
  if (module === 'marketing' && sub === 'graphic-design') {
    return { module: 'graphic-design', subModule: resolveSubModule('graphic-design') };
  }
  // Removed: 規劃中心 was a mock-only module
  if (module === 'planning-center') {
    return { module: 'dashboard', subModule: resolveSubModule('dashboard') };
  }
  // Removed: 通知設定 was a local-state demo page
  if (module === 'settings' && sub === 'notifications') {
    return { module: 'settings', subModule: resolveSubModule('settings') };
  }
  // Removed: V1 藝人表格 preview. Live form is 藝人管理 → 新增藝人.
  if (module === 'settings' && sub === 'talent-form') {
    return { module: 'talent', subModule: 'invite' };
  }
  // Removed: 待跟進項目 was a mock-only website page
  if (module === 'website' && sub === 'pending') {
    return { module: 'website', subModule: resolveSubModule('website', 'list') };
  }
  // Removed: 文章列表 was unused mock content
  if (module === 'website' && sub === 'articles-list') {
    return { module: 'website', subModule: resolveSubModule('website', 'list') };
  }
  // Removed: in-app quotation generation. Documents are uploaded to quotation_docs.
  if (isQuotationSectionModule(module) && (sub === 'new' || sub === 'items')) {
    return { module, subModule: 'list' };
  }
  // Removed: mock-only finance invoice / payment / card / company pages.
  if (
    module === 'finance' &&
    (sub === 'invoices' || sub === 'payments' || sub === 'credit-cards' || sub === 'by-company')
  ) {
    return { module: 'finance', subModule: 'recurring' };
  }
  if (HIDDEN_DEMO_MODULES.has(module) || module === 'asana-pending' || sub === 'asana-pending') {
    return { module: 'dashboard', subModule: resolveSubModule('dashboard') };
  }
  if (module === 'marketing' && (sub === 'ads-data-sync' || sub === 'backlink')) {
    return { module: 'marketing', subModule: 'google-ads' };
  }
  if (module === 'settings' && sub === 'email-connection') {
    return { module: 'settings', subModule: resolveSubModule('settings') };
  }
  return { module, subModule: resolveSubModule(module, sub) };
}

export interface MainMenuItem {
  id: string;
  label: string;
  subMenus: SubMenuItem[];
}

const quotationSectionSubMenus: SubMenuItem[] = [
  { id: 'pitching', label: 'Pitching' },
  { id: 'projects', label: 'Project' },
  { id: 'list', label: '報價單列表' },
  { id: 'clients', label: '客戶列表' },
  { id: 'doc-types', label: '文件類型', section: '設置' },
];

const HIDDEN_DEMO_MODULES = new Set([
  'system-dev',
  'project',
  'website',
  'video',
  'graphic-design',
  'talent',
  'supplier',
  'tools-center',
  'finance',
]);

export const mainMenuItems: MainMenuItem[] = [
  {
    id: 'dashboard',
    label: '首頁',
    subMenus: [
      { id: 'overview', label: '儀表板' },
      { id: 'my-projects', label: '我的項目' },
    ],
  },
  {
    id: 'day-report',
    label: '工作匯報',
    subMenus: [
      { id: 'submit', label: '提交匯報', section: '每日必做' },
      { id: 'today-team', label: '今日團隊', section: '每日必做' },
      { id: 'team-view', label: '匯報統計', section: '管理分析' },
      { id: 'analytics', label: '項目分析', section: '管理分析' },
      { id: 'work-report', label: '工作報表', section: '管理分析' },
      { id: 'work-categories', label: '工作類型', section: '設置' },
    ],
  },
  {
    id: 'quotation',
    label: '市場項目管理',
    subMenus: quotationSectionSubMenus,
  },
  {
    id: 'marketing',
    label: '行銷管理',
    subMenus: [
      { id: 'google-ads', label: 'Google Ads', section: '廣告' },
      { id: 'facebook-ads', label: 'Facebook Ads', section: '廣告' },
      { id: 'ads-cost-trend', label: '廣告成本趨勢', section: '廣告' },
      { id: 'ads-click-trend', label: '廣告點擊趨勢', section: '廣告' },
      { id: 'ads-comparison', label: '廣告比較圖表', section: '廣告' },
      { id: 'ads-tags', label: '廣告標籤', section: '設定' },
    ],
  },
  {
    id: 'settings',
    label: '系統設定',
    subMenus: [
      { id: 'profile', label: '個人設定' },
      { id: 'staff-directory', label: '員工列表' },
      { id: 'companies', label: '公司管理' },
      { id: 'brands', label: '品牌管理' },
      { id: 'users', label: '用戶管理' },
      { id: 'login-logs', label: '登入紀錄' },
    ],
  },
];

interface AppContextType {
  user: User;
  currentModule: string;
  setCurrentModule: (module: string) => void;
  currentSubModule: string;
  setCurrentSubModule: (subModule: string) => void;
  navigateTo: (module: string, subModule?: string) => void;
  sidebarCollapsed: boolean;
  setSidebarCollapsed: (collapsed: boolean) => void;
  selectedCompanyId: string | null;
  setSelectedCompanyId: (id: string | null) => void;
  selectedBrandId: string | null;
  setSelectedBrandId: (id: string | null) => void;
}

const fallbackUser: User = {
  id: '0',
  name: 'User',
  email: '',
  role: 'management',
  accessibleCompanies: ['c1', 'c2', 'c3'],
};

// Use globalThis to persist context across HMR reloads
const APP_CONTEXT_KEY = '__AppContext__';
if (!(globalThis as any)[APP_CONTEXT_KEY]) {
  (globalThis as any)[APP_CONTEXT_KEY] = createContext<AppContextType | undefined>(undefined);
}
const AppContext = (globalThis as any)[APP_CONTEXT_KEY] as React.Context<AppContextType | undefined>;

export function AppProvider({ children }: { children: ReactNode }) {
  const { systemUser, session } = useAuth();
  // Parse module/submodule from hash: #module/submodule[?query]
  // Query strings (e.g. campaign detail) must not pollute the submenu id.
  const parseHash = () => {
    const hash = window.location.hash.replace(/^#/, '');
    const path = (hash.split('?')[0] || '').replace(/^\/+/, '');
    const [mod, sub] = path.split('/');
    return { mod: mod || 'dashboard', sub: sub || '' };
  };

  const [currentModule, setCurrentModule] = useState(() => {
    const { mod, sub } = parseHash();
    const resolved = resolveRoute(mod, sub || undefined);
    // Bind the first page to a fetch generation before child effects run, so
    // the later hashchange/normalize cannot abort those GETs as "stale".
    beginPageNavigation(`${resolved.module}/${resolved.subModule}`);
    return resolved.module;
  });
  const [currentSubModule, setCurrentSubModule] = useState(() => {
    const { mod, sub } = parseHash();
    return resolveRoute(mod, sub || undefined).subModule;
  });

  // Normalize hash if it points to a hidden/invalid/legacy sub-module.
  // Preserve any query string (e.g. campaign detail params).
  useEffect(() => {
    const { mod, sub } = parseHash();
    const resolved = resolveRoute(mod, sub || undefined);
    const raw = window.location.hash.replace(/^#/, '');
    const qIndex = raw.indexOf('?');
    const query = qIndex >= 0 ? raw.slice(qIndex) : '';
    const path = (qIndex >= 0 ? raw.slice(0, qIndex) : raw).replace(/^\/+/, '');
    const expectedPath = `${resolved.module}/${resolved.subModule}`;
    if (path !== expectedPath) {
      window.location.replace(`#${expectedPath}${query}`);
    }
  }, []);

  // Keep hash in sync when state changes externally (e.g. browser back/forward)
  useEffect(() => {
    const onHashChange = () => {
      const { mod, sub } = parseHash();
      const resolved = resolveRoute(mod, sub || undefined);
      beginPageNavigation(`${resolved.module}/${resolved.subModule}`);
      setCurrentModule(resolved.module);
      setCurrentSubModule(resolved.subModule);
      const raw = window.location.hash.replace(/^#/, '');
      const qIndex = raw.indexOf('?');
      const query = qIndex >= 0 ? raw.slice(qIndex) : '';
      const path = (qIndex >= 0 ? raw.slice(0, qIndex) : raw).replace(/^\/+/, '');
      const expectedPath = `${resolved.module}/${resolved.subModule}`;
      if (path !== expectedPath) {
        window.location.replace(`#${expectedPath}${query}`);
      }
    };
    window.addEventListener('hashchange', onHashChange);
    return () => window.removeEventListener('hashchange', onHashChange);
  }, []);
  const [sidebarCollapsed, setSidebarCollapsed] = useState(false);
  const [selectedCompanyId, setSelectedCompanyId] = useState<string | null>(null);
  const [selectedBrandId, setSelectedBrandId] = useState<string | null>(null);

  // Derive the user dynamically from the authenticated systemUser profile
  const user: User = useMemo(() => {
    if (!systemUser) return fallbackUser;
    
    // Ensure role is a valid UserRole, default to 'management' if not mappable
    const validRoles: UserRole[] = ['management', 'project_manager', 'designer', 'accountant', 'copywriter', 'video_editor', 'marketing', 'staff'];
    const mappedRole: UserRole = validRoles.includes(systemUser.role as UserRole)
      ? (systemUser.role as UserRole)
      : 'management';

    return {
      id: systemUser.id || '0',
      name: systemUser.display_name || session?.user?.user_metadata?.full_name || session?.user?.email || 'User',
      email: systemUser.email || session?.user?.email || '',
      role: mappedRole,
      department: systemUser.department || undefined,
      accessibleCompanies: ['c1', 'c2', 'c3'],
    };
  }, [systemUser, session]);

  const navigateTo = useCallback((module: string, subModule?: string) => {
    const resolved = resolveRoute(module, subModule);
    beginPageNavigation(`${resolved.module}/${resolved.subModule}`);
    setCurrentModule(resolved.module);
    setCurrentSubModule(resolved.subModule);
    // Update the URL hash so refresh restores the same page
    window.location.hash = `${resolved.module}/${resolved.subModule}`;
  }, []);

  // Hash-aware wrappers so any direct setCurrentModule/setCurrentSubModule call also updates the URL
  const setModuleWithHash = useCallback((module: string) => {
    const resolved = resolveRoute(module);
    beginPageNavigation(`${resolved.module}/${resolved.subModule}`);
    setCurrentModule(resolved.module);
    setCurrentSubModule(resolved.subModule);
    window.location.hash = `${resolved.module}/${resolved.subModule}`;
  }, []);

  const setSubModuleWithHash = useCallback((subModule: string) => {
    beginPageNavigation(`${currentModule}/${subModule}`);
    setCurrentSubModule(subModule);
    window.location.hash = `${currentModule}/${subModule}`;
  }, [currentModule]);

  return (
    <AppContext.Provider
      value={{
        user: user,
        currentModule,
        setCurrentModule: setModuleWithHash,
        currentSubModule,
        setCurrentSubModule: setSubModuleWithHash,
        navigateTo,
        sidebarCollapsed,
        setSidebarCollapsed,
        selectedCompanyId,
        setSelectedCompanyId,
        selectedBrandId,
        setSelectedBrandId,
      }}
    >
      {children}
    </AppContext.Provider>
  );
}

export function useApp() {
  const context = useContext(AppContext);
  if (!context) {
    throw new Error('useApp must be used within an AppProvider');
  }
  return context;
}
