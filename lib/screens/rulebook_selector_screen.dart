import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../logic/game_state.dart';
import '../widgets/app_background.dart';
import '../widgets/tr_text.dart';
import 'custom_rulebook_screen.dart';
import 'role_selection_screen.dart';

/// Lets the game master pick which rulebook/ruleset this game follows.
/// Each rulebook can have its own default role mix, win conditions, and
/// night/day action rules. Right now only "Mafia Psychology Academy -
/// Advanced" (the ruleset built throughout this app) is fully wired up;
/// the others are shown so the intended structure is visible, and will be
/// built out one at a time in future updates.
class RulebookSelectorScreen extends StatelessWidget {
  final int totalPlayers;
  final int mafiaCount;
  final int citizenCount;
  final int independentCount;
  final GameState gameState;

  const RulebookSelectorScreen({
    super.key,
    required this.totalPlayers,
    required this.mafiaCount,
    required this.citizenCount,
    required this.independentCount,
    required this.gameState,
  });

  static const _comingSoon = [
    (
      'Classic',
      'کلاسیک',
      '7 players - Villager x3, Cop, Doctor, Mafia x2',
      '۷ نفره - شهروند×۳، کارآگاه، دکتر، مافیا×۲',
    ),
    (
      'Mountainous 11v2',
      'کوهستانی ۱۱ در برابر ۲',
      '13 players - Villager x11, Mafia x2, no power roles',
      '۱۳ نفره - شهروند×۱۱، مافیا×۲، بدون نقش قدرت',
    ),
    (
      'Advanced Roles Mix (11 Players)',
      'ترکیب نقش‌های پیشرفته (۱۱ نفره)',
      '11 players - Seer, Martyr, Hunter, Wolves x2, Cultist',
      '۱۱ نفره - غیب‌گو، فداکار، شکارچی، گرگ×۲، فرقه‌گرا',
    ),
    (
      'Town-Heavy Power Setup',
      'قدرت‌محور شهروندی',
      '7 players - Villager x5, Cop, Doctor, Mafia x2',
      '۷ نفره - شهروند×۵، کارآگاه، دکتر، مافیا×۲',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [TrText('Choose Rulebook'), Text(' / انتخاب رول‌بوک')],
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _RulebookCard(
                titleEn: 'Mafia Psychology Academy - Advanced',
                titleFa: 'مافیای پیشرفته آکادمی',
                subtitleEn: 'Every role built in this app, with the full '
                    'wake-order and no-shot rules - ready to play now.',
                subtitleFa: 'همه‌ی نقش‌های ساخته‌شده در این اپ، با ترتیب '
                    'کامل بیدارشدن و قانون ناتویی - همین الان آماده‌ی بازیه.',
                active: true,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RoleSelectionScreen(
                        totalPlayers: totalPlayers,
                        mafiaCount: mafiaCount,
                        citizenCount: citizenCount,
                        independentCount: independentCount,
                        gameState: gameState,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textGold,
                    side: const BorderSide(color: AppColors.textGold, width: 1.5),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const CustomRulebookScreen()),
                    );
                  },
                  icon: const Icon(Icons.edit_note_rounded),
                  label: const Text('Custom Rulebook / رول‌بوک سفارشی'),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    TrText(
                      'More rulebooks (coming soon)',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                    Text(
                      ' / رول‌بوک‌های بیشتر (به‌زودی)',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              for (final (en, fa, subEn, subFa) in _comingSoon)
                _RulebookCard(
                  titleEn: en,
                  titleFa: fa,
                  subtitleEn: subEn,
                  subtitleFa: subFa,
                  active: false,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Not built yet - coming in a future update. / '
                          'هنوز ساخته نشده - در به‌روزرسانی بعدی می‌آید.',
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RulebookCard extends StatelessWidget {
  final String titleEn;
  final String titleFa;
  final String subtitleEn;
  final String subtitleFa;
  final bool active;
  final VoidCallback onTap;

  const _RulebookCard({
    required this.titleEn,
    required this.titleFa,
    required this.subtitleEn,
    required this.subtitleFa,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.citizenTeam : AppColors.textSecondary;
    return Opacity(
      opacity: active ? 1.0 : 0.55,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TrText(
                        titleEn,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: color,
                        ),
                      ),
                    ),
                    if (active)
                      const Icon(Icons.check_circle, color: AppColors.citizenTeam, size: 18)
                    else
                      const Icon(Icons.lock_clock, color: AppColors.textSecondary, size: 16),
                  ],
                ),
                Text(titleFa, style: TextStyle(fontSize: 12, color: color)),
                const SizedBox(height: 4),
                TrText(subtitleEn, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
                Text(subtitleFa,
                    style: const TextStyle(fontSize: 11, color: AppColors.textGold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
