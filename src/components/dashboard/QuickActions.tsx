import { FileText, DollarSign, FolderKanban, Megaphone } from 'lucide-react';
import { useApp } from '@/context/AppContext';

const shortcuts = [
  { id: 'report', label: '提交日報', icon: FileText, module: 'day-report', subModule: 'submit', color: 'bg-teal-50 text-teal-600' },
  { id: 'quote', label: '報價單列表', icon: DollarSign, module: 'quotation', subModule: 'list', color: 'bg-amber-50 text-amber-600' },
  { id: 'pitch', label: 'Pitching', icon: FolderKanban, module: 'quotation', subModule: 'pitching', color: 'bg-blue-50 text-blue-600' },
  { id: 'ads', label: 'Google Ads', icon: Megaphone, module: 'marketing', subModule: 'google-ads', color: 'bg-rose-50 text-rose-600' },
];

export function QuickActions() {
  const { navigateTo } = useApp();

  return (
    <div className="grid grid-cols-2 lg:grid-cols-4 gap-3">
      {shortcuts.map((item) => {
        const Icon = item.icon;
        return (
          <button
            key={item.id}
            onClick={() => navigateTo(item.module, item.subModule)}
            className="bg-white rounded-md border border-[rgba(13,26,45,0.08)] shadow-card p-4 flex flex-col items-center gap-2.5 hover:shadow-card-hover transition-all duration-200 active:scale-[0.97]"
          >
            <div className={`w-10 h-10 rounded-md flex items-center justify-center ${item.color}`}>
              <Icon size={18} />
            </div>
            <span className="text-[13px] font-medium text-center">{item.label}</span>
          </button>
        );
      })}
    </div>
  );
}
