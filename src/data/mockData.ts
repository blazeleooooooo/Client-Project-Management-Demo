/**
 * Demo fallback records — generic Acme names only.
 */
import { Company, Brand, Project, YearPlan } from '@/types/app';

export { isSampleData, filterOutSampleData, getOnlySampleData, SAMPLE_BADGE_TEXT } from '@/data/sampleDataRegistry';

export const companies: (Company & { __sampleData: true })[] = [
  {
    __sampleData: true,
    id: 'acme',
    uuid: '11111111-1111-4111-8111-111111111111',
    companyCode: 'ACME',
    companyNameZh: 'Acme Corp',
    companyNameEn: 'Acme Corporation',
    brNo: '00000000-000-00-00-0',
    bankName: 'Demo Bank',
    bankAccount: '000-000-000000-000',
    address: '100 Demo Street, Example City',
    contactPerson: 'Alex Rivera',
    contactPhone: '+1 555 0100',
    contactEmail: 'hello@example.com',
    logoUrl: '',
    isActive: true,
    brandCount: 1,
    activeProjectCount: 2,
  },
];

export const brands: (Brand & { __sampleData: true })[] = [
  {
    __sampleData: true,
    id: '22222222-2222-4222-8222-222222222222',
    companyId: '11111111-1111-4111-8111-111111111111',
    brandCode: 'ACME',
    displayName: 'Acme',
    isActive: true,
    projectCount: 2,
  },
];

export const projects: (Project & { __sampleData: true })[] = [
  {
    __sampleData: true,
    id: 'p1',
    name: 'Acme website refresh',
    clientName: 'Northwind Traders',
    companyId: 'acme',
    brandId: '22222222-2222-4222-8222-222222222222',
    projectType: 'web_design',
    projectCategory: 'client',
    status: 'active',
    progress: 60,
    assignedPm: 'Jordan Lee',
    brand: 'Acme',
    company: 'ACME',
    budgetTotal: 40000,
    budgetUsed: 18000,
    startDate: '2026-01-01',
    endDate: '2026-06-30',
    priority: 'high',
  },
];

export const yearPlans: (YearPlan & { __sampleData: true })[] = [
  {
    __sampleData: true,
    id: 'yp1',
    companyId: 'acme',
    brandId: '22222222-2222-4222-8222-222222222222',
    year: 2026,
    targetRevenue: 250000,
    targetProjects: 8,
    targetArticles: 24,
    targetVideos: 12,
    targetSocialPosts: 60,
    notes: 'Acme 2026 demo targets',
  },
];

export const projectTypeLabels: Record<string, string> = {
  web_design: '網站設計',
  system: '系統開發',
  graphic_design: '平面設計',
  event: '活動策劃',
  wine: '紅酒推廣',
  branding: '品牌設計',
  marketing: '行銷推廣',
  video: '影片製作',
  social_media: '社交媒體',
  edm: 'EDM 營銷',
  paid_ads: '付費廣告',
  seo_upgrade: 'SEO 升級',
  other: '其他',
};

export const statusConfig: Record<string, { label: string; color: string; textColor: string; bgColor: string }> = {
  planning: { label: '規劃中', color: 'bg-blue-500', textColor: 'text-blue-700', bgColor: 'bg-blue-50' },
  active: { label: '進行中', color: 'bg-teal-600', textColor: 'text-teal-700', bgColor: 'bg-teal-50' },
  on_hold: { label: '暫停', color: 'bg-amber-500', textColor: 'text-amber-700', bgColor: 'bg-amber-50' },
  completed: { label: '已完成', color: 'bg-slate-500', textColor: 'text-slate-700', bgColor: 'bg-slate-50' },
  cancelled: { label: '已取消', color: 'bg-rose-500', textColor: 'text-rose-700', bgColor: 'bg-rose-50' },
};

export const priorityConfig: Record<string, { label: string; color: string }> = {
  low: { label: '低', color: 'bg-green-100 text-green-700' },
  medium: { label: '中', color: 'bg-blue-100 text-blue-700' },
  high: { label: '高', color: 'bg-amber-100 text-amber-700' },
  urgent: { label: '緊急', color: 'bg-rose-100 text-rose-700' },
};
