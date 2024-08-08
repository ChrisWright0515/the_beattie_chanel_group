import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/button.dart';
import '../../../components/logo.dart';
import '../../../constants.dart';
import '../../../services/listing_service.dart';
import '../../../models/listing.dart';
import '../../property_details/property_details_screen.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const WelcomeHeader(),
          // SearchBar(),
          const SizedBox(height: 16),
          ListingsWidget(
            header: 'Our Listings',
            listingsStream: ListingService().getAgentListings(),
          ),
          const SizedBox(height: 16),
          ListingsWidget(
            header: 'Current Listings',
            listingsStream: ListingService().getRecentListings(),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }
}

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x39000000),
            offset: Offset(0.0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(24, 20, 0, 0),
            child: LogoTextRow(),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 12, 24, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Welcome!',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontFamily: 'Outfit',
                        color: Theme.of(context).colorScheme.tertiary,
                        letterSpacing: 0,
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Find your Dream Home',
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ],
            ),
          ),
          const SearchBar(),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: const AlignmentDirectional(0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                child: TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Address, city, state...',
                    labelStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0x00000000),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    prefixIcon: const Icon(
                      Icons.search_sharp,
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontFamily: 'Plus Jakarta Sans',
                        color: Theme.of(context).colorScheme.secondary,
                        letterSpacing: 0,
                      ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
              child: Button(
                onPressed: () async {},
                text: 'Search',
                options: ButtonOptions(
                  width: 100,
                  height: 40,
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: Theme.of(context).primaryColor,
                  textStyle: const TextStyle(
                    // fontFamily: 'Plus Jakarta Sans',
                    color: Colors.black,
                    letterSpacing: 0,
                  ),
                  elevation: 2,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ListingsWidget extends StatelessWidget {
  final String header;
  final Stream<List<Listing>> listingsStream;

  const ListingsWidget({
    super.key,
    required this.header,
    required this.listingsStream,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
            child: Text(
              header,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontFamily: 'Outfit',
                    letterSpacing: 0,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          StreamBuilder<List<Listing>>(
            stream: listingsStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                );
              }
              List<Listing> listViewListingsRecordList = snapshot.data!;

              return SizedBox(
                height:
                    300, // Set an appropriate height for the horizontal list
                child: ListView.builder(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: listViewListingsRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewListingsRecord =
                        listViewListingsRecordList[listViewIndex];
                    return Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                      child: ListingItemWidget(
                        listing: listViewListingsRecord,
                        index: listViewIndex,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ListingItemWidget extends StatelessWidget {
  final Listing listing;
  final int index;
  const ListingItemWidget(
      {super.key, required this.listing, required this.index});

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(symbol: '\$');

    return Container(
      constraints: const BoxConstraints(
        minWidth: 200, // Minimum width for the card
        maxWidth: 300, // Maximum width for the card
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            blurRadius: 4,
            color: Color(0x32000000),
            offset: Offset(0.0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailsScreen(listing: listing),
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (listing.images != null && listing.images!.isNotEmpty)
              Hero(
                tag: valueOrDefault<String>(
                  listing.images!.first,
                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/jyeiyll24v90/pixasquare-4ojhpgKpS68-unsplash.jpg' +
                      '$index',
                ),
                transitionOnUserGestures: true,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    valueOrDefault<String>(
                      listing.images!.first,
                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/sample-app-property-finder-834ebu/assets/jyeiyll24v90/pixasquare-4ojhpgKpS68-unsplash.jpg' +
                          '$index',
                    ),
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      listing.addressLine1.maybeHandleOverflow(
                        maxChars: 36,
                        replacement: '…',
                      ),
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontFamily: 'Outfit',
                                letterSpacing: 0,
                              ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          listing.propertyType!.maybeHandleOverflow(
                            maxChars: 90,
                            replacement: '…',
                          ),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontFamily: 'Plus Jakarta Sans',
                                    letterSpacing: 0,
                                  ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                          child: Row(
                            children: [
                              // beds
                              Row(
                                children: [
                                  const Icon(
                                    Icons.king_bed_rounded,
                                    // color: Color(0xFF4B39EF),
                                    // size: 24,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${listing.bedrooms} Beds',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontFamily: 'Plus Jakarta Sans',
                                          letterSpacing: 0,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16),
                              // baths
                              Row(
                                children: [
                                  const Icon(
                                    Icons.bathtub_rounded,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${listing.bathrooms} baths',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontFamily: 'Plus Jakarta Sans',
                                          letterSpacing: 0,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                      child: Text(
                        currencyFormatter.format(listing.price),
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontFamily: 'Outfit',
                                  // color: Theme.of(context)
                                  //     .colorScheme
                                  //     .primary,
                                  letterSpacing: 0,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
