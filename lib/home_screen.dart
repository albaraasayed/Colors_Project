// import 'package:first_flutter/common/colors.dart';
// import 'package:flutter/material.dart';
//
// import 'common/category_grid_item.dart';
// import 'common/coin_price_card.dart';
// import 'common/custom_bottom_nav.dart';
// import 'common/svg_icon_button.dart';
// import 'common/trading_option_card.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.darkBackground,
//       appBar: AppBar(
//         backgroundColor: AppColors.darkBackground,
//         elevation: 0,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
//           child: GestureDetector(
//             onTap: () {
//
//             },
//             child: CircleAvatar(
//               backgroundColor: AppColors.darkBackground,
//               backgroundImage:  AssetImage('assets/images/avatar.png'),
//             ),
//           ),
//         ),
//         actions: const [
//           SvgIconButton(assetPath: 'assets/images/search.svg'),
//           SvgIconButton(assetPath: 'assets/images/catigories.svg'),
//           SvgIconButton(assetPath: 'assets/images/notification.svg'),
//           SizedBox(width: 14),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24.0,
//                   vertical: 20.0,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         CategoryGridItem(
//                           assetPath: 'assets/images/deposit.svg',
//                           label: 'Deposit',
//                         ),
//                         CategoryGridItem(
//                           assetPath: 'assets/images/referral.svg',
//                           label: 'Referral',
//                         ),
//                         CategoryGridItem(
//                           assetPath: 'assets/images/gridtrading.svg',
//                           label: 'Grid Trading',
//                         ),
//                         CategoryGridItem(
//                           assetPath: 'assets/images/margin.svg',
//                           label: 'Margin',
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         CategoryGridItem(
//                           assetPath: 'assets/images/launchpad.svg',
//                           label: 'Launchpad',
//                         ),
//                         CategoryGridItem(
//                           assetPath: 'assets/images/savings.svg',
//                           label: 'Savings',
//                         ),
//                         CategoryGridItem(
//                           assetPath: 'assets/images/liuidswap.svg',
//                           label: 'Liquid Swap',
//                         ),
//                         CategoryGridItem(
//                           assetPath: 'assets/images/more.svg',
//                           label: 'More',
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFF8F9FA),
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(30),
//                     ),
//                   ),
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.only(top: 24, bottom: 100),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                           child: Column(
//                             children: const [
//                               TradingOptionCard(
//                                 title: 'P2P Trading',
//                                 subtitle: 'Bank Transfer, Paypal Revolut...',
//                                 assetPath: 'assets/images/rocket.png',
//                               ),
//                               SizedBox(height: 16),
//                               TradingOptionCard(
//                                 title: 'Credit/Debit Card',
//                                 subtitle: 'Visa, Mastercard',
//                                 assetPath: 'assets/images/card.png',
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 32),
//
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 24.0),
//                           child: Text(
//                             'Recent Coin',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                           child: Row(
//                             children: const [
//                               CoinPriceCard(
//                                 price: '40,059.83',
//                                 pair: 'BTC/BUSD',
//                                 change: '+0.81%',
//                                 isPositive: true,
//                                 iconPath: 'assets/images/Bitcoin.svg',
//                                 iconColor: Colors.orange,
//                               ),
//                               SizedBox(width: 16),
//                               CoinPriceCard(
//                                 price: '15.83',
//                                 pair: 'LINK/BUSD',
//                                 change: '-0.81%',
//                                 isPositive: false,
//                                 iconPath: 'assets/images/chainlink.svg',
//                                 iconColor: Colors.blueAccent,
//                               ),
//                               SizedBox(width: 16),
//                               CoinPriceCard(
//                                 price: '40,059.83',
//                                 pair: 'BTC/BUSD',
//                                 change: '+0.81%',
//                                 isPositive: true,
//                                 iconPath: 'assets/images/Bitcoin.svg',
//                                 iconColor: Colors.orange,
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(height: 32),
//
//                         const Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 24.0),
//                           child: Text(
//                             'Top Coins',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                           child: Row(
//                             children: const [
//                               CoinPriceCard(
//                                 price: '40,059.83',
//                                 pair: 'MFT/BUSD',
//                                 change: '+0.81%',
//                                 isPositive: true,
//                                 iconPath: 'assets/images/MFT.svg',
//                                 iconColor: Color(0xFF6B46C1),
//                               ),
//                               SizedBox(width: 16),
//                               CoinPriceCard(
//                                 price: '2,059.83',
//                                 pair: 'REN/BUSD',
//                                 change: '-0.81%',
//                                 isPositive: false,
//                                 iconPath: 'assets/images/REN.svg',
//                                 iconColor: Color(0xFF1E1E1E),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: EdgeInsets.all(24.0),
//               child: CustomBottomNav(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
