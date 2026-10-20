import { KPIStatsGrid } from './KPIStatsGrid';
import { ProjectProgressPanel } from './ProjectProgressPanel';
import { QuickActions } from './QuickActions';
import { RecentActivity } from './RecentActivity';
import { MyProjects } from './MyProjects';
import { useApp } from '@/context/AppContext';

interface DashboardModuleProps {
  subModule?: string;
}

function DashboardOverview() {
  const { user } = useApp();

  return (
    <div className="space-y-6">
      {/* Page Title */}
      <div>
        <h1 className="text-[32px] font-bold tracking-tight">儀表板</h1>
        <p className="text-[14px] text-muted-foreground mt-1">
          歡迎回來，{user.name}
        </p>
      </div>

      <div className="rounded-md border border-teal-200 bg-white px-4 py-3 shadow-card">
        <p className="text-[13px] font-semibold text-[#0d1a2d]">Portfolio demo · synthetic data only</p>
        <p className="mt-1 text-[13px] leading-relaxed text-muted-foreground">
          You are signed in as the visitor account. Companies and metrics are fictional
          (Acme, Northwind, Contoso). The workspace labels are Traditional Chinese.
          Start with <span className="font-medium text-[#0d1a2d]">工作匯報</span>,{' '}
          <span className="font-medium text-[#0d1a2d]">市場項目管理 → Pitching</span>, or{' '}
          <span className="font-medium text-[#0d1a2d]">行銷管理 → Google Ads</span>.
        </p>
      </div>

      {/* KPI Stats */}
      <KPIStatsGrid />

      {/* Quick Actions */}
      <QuickActions />

      {/* Project Progress (full width) */}
      <ProjectProgressPanel />

      {/* Recent Activity */}
      <RecentActivity />
    </div>
  );
}

export function DashboardModule({ subModule }: DashboardModuleProps) {
  switch (subModule) {
    case 'my-projects':
      return <MyProjects />;
    case 'overview':
    default:
      return <DashboardOverview />;
  }
}
